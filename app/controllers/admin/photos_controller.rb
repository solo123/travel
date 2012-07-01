class Admin::PhotosController < Admin::ResourceController

  create.after :create_after

  def create_after
    if params[:destination_id]
      @destination = Destination.find(params[:destination_id])
      @destination.photos << @photo
    end
  end
  def location_after_save
    admin_destination_photos_url(@destination)
  end
  
  def cover
    @destination = Destination.find(params[:destination_id])
    @destination.photo_id = params[:photo_id]
    @destination.save
  end
    
	private
	def load_data
		if params[:destination_id]
    	@destination = Destination.find(params[:destination_id])
    end
  end
	def collection
    return @collection if @collection.present?
    if params[:destination_id]
      @destination = Destination.find(params[:destination_id])
      @collection = @destination.photos
    end
    
    # pagination_options = {
                            # :per_page  => Spree::Config[:admin_products_per_page],
                            # :page      => params[:page]}
#                             
    # @search = Photo.search(params[:search])
    # @collection = @search.paginate(pagination_options)
  end
	
end