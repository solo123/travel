class OrdersController < ApplicationBaseController
  def new
    redirect_back_or_default '/login' if !current_user
    @tour = Tour.find(params[:tour_id])
    @order = Order.new
    @datelist = []
    @max_date = Date.today + 30
    @addresses = UserInfo.find_by_user_id(current_user.id).addresses
    if @tour.schedules.count > 0
      @datelist = @tour.schedules.map {|s| s.departure_date.strftime('%Y.%m.%d')}.join(',')
      @max_date = (@tour.schedules.last.departure_date.to_date - Date.today).to_i
    end    
  end

  def edit
    unless params[:commit]
      dt = Date.strptime(params[:departure], '%m/%d/%Y')
      schedule = Schedule.where(:tour_id => params[:tour_id], :departure_date => dt).first
      rooms = params[:rooms].split ','
      @fares = 0.0
      rooms.each do |num|
        @fares += schedule.price.room_price(num)
      end
    else
      @error_msg = nil
      userinfo = Infos::UserInfo.find_by_user_id(current_user.id)
      dt = Date.strptime(params[:departure], '%m/%d/%Y')
      schedule = Operates::Schedule.where(:tour_id => params[:tour_id], :departure_date => dt).first
      rooms = params[:rooms].split ','
      order = Operates::Order.new
      order.customer_name = userinfo.full_name
      order.customer_id = userinfo.id
      order.order_source_type = 'Operates::Schedule'
      order.order_source_id = schedule.id
      order.state = 'new'
      order.order_method = 'website'
      rooms.each do |num|
        item = order.items.build
        item.num_adult = item.num_total = num.to_i
        item.amount = schedule.price.room_price(num)
      end
      order.build_customer
      order.customer.customer_id = userinfo.id
      order.customer.full_name = userinfo.full_name
      order.build_order_operate
      order.save
      render 'order_saved.js'
    end
  end

  def prices
    dt = Date.strptime(params[:departure], '%m/%d/%Y')
    schedule = Operates::Schedule.where(:tour_id => params[:tour_id], :departure_date => dt).first
    if schedule
      @price = schedule.price
    end
  end
end
