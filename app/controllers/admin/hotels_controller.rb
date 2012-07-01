class Admin::HotelsController < Admin::ResourceController


	private
	def collection
        return @collection if @collection.present?

        params[:search] ||= {}
        params[:search][:meta_sort] ||= "name.asc"
        @search = super.metasearch(params[:search])

        @collection = @search.relation.group_by_products_id.includes({:variants => [:images, :option_values]}).page(params[:page]).per(Spree::Config[:admin_products_per_page])
        
        pagination_options = {:include   => {:variants => [:images, :option_values]},
                                :per_page  => Spree::Config[:admin_products_per_page],
                                :page      => params[:page]}
                                
        @search = Hotel.search(params[:search])
        @collection = @search.paginate(pagination_options)
    end
	
end