class Admin::CustomersController < Admin::BaseController

  def index
    return @customers if @customers.present?
    params[:search] ||= {}
    params[:search][:meta_sort] ||= "title.asc"
    @search = Infos::UserInfo.metasearch(params[:search])
    @customers = @search.page(params[:page]).per(Spree::Config[:admin_products_per_page])
  end
  
  def show
    if params[:id] == 'search'
      @customers = []
      if params[:type]
        if params[:type] == 'name'
          s = params[:q]
          @customers = Infos::UserInfo.where('full_name like "%'+ s +'%"')
        elsif params[:type] == 'tel'
        elsif params[:type] == 'email'
        elsif params[:type] == 'address'
        end
      end
      render 'search', :layout => false
    end
  end
  
  def search
    txt = ''
    if params[:q]
      customers = Infos::UserInfo.where('full_name like "%' + params[:q] + '%"')
      customers.limit(100).each do |c|
        tel = c.telephones.first
        addr = c.addresses.first
        txt << "#{c.id}|#{c.full_name}|#{tel.tel if tel} #{addr.address1 if addr}\n"
      end
    end
    render :text => txt      
  end
  
end