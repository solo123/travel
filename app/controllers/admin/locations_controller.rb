class Admin::LocationsController < Admin::ResourceController


	private
	def collection
    return @collection if @collection.present?
    
    pagination_options = {
                            :per_page  => Spree::Config[:admin_products_per_page],
                            :page      => params[:page]
                         }
                            
    @search = Location.search(params[:search])
    @collection = @search.paginate(pagination_options)

  
  end
	
end