class Admin::ShopOrdersController < Admin::BaseController
  helper :icon_link

  def index
    return @shop_orders if @shop_orders.present?

    params[:search] ||= {}
    @search = Operates::Order.metasearch(params[:search])
    @shop_orders = @search.page(params[:page]).per(Spree::Config[:admin_products_per_page])
  end
  
  def show
    @shop_order = Operates::Order.find(params[:id])
  end
  
  def edit
    @shop_order = Operates::Order.find(params[:id])
  end
  
  def update
    @shop_order = Operates::Order.find(params[:id])
    if params[:op] == 'change_schedule' && params[:tour_id].length > 0
      tour = Infos::Tour.find(params[:tour_id])
      schedule = tour.schedules.where(:departure_date => params[:departure_date]).first
      if schedule
        @shop_order.order_source = schedule
        @shop_order.save
      end
    else
      @shop_order.update_attributes(params[:operates_order])
    end
    @shop_order = Operates::Order.find(params[:id])
    @shop_order.price_changed if params[:price_changed] #change prices if changed.
  end
  
  def new
    if params[:op]
      render 'new_order'
      return
    else
      @shop_order = Operates::Order.new
      @shop_order.save
      redirect_to :action => 'show', :id => @shop_order
    end
  end
  def create
    if params[:op] && params[:op] == 'quick_order'
      order = Operates::Order.new
      order.customer_id = params[:customer_id]
      order.order_source_type = 'Operates::Schedule'
      order.order_source_id = params[:order_schedule_id]
      order.special_instructions = params[:special_instructions]
      params[:adult].each_with_index do |a, idx|
        if a.to_i > 0
          item = order.items.build
          item.num_adult = a.to_i
          item.num_child = params[:child][idx].to_i
        end
      end
      order.price_changed
      order.save
      render :text => 'after_order_saved()'
      return
    else 
      @shop_order = Operates::Order.new(params[:operates_order])
      @shop_order.save
      redirect_to :action => 'show', :id => @shop_order
    end
  end


end
