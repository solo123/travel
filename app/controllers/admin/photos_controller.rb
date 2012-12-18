module Admin
class PhotosController < AdminController
  respond_to :html
  
  def index
    load_collection
  end
  def show
    load_object
  end
  def new
    @parent = Destination.find(params[:destination_id]) if params[:destination_id]
    @parent = Bus.find(params[:bus_id]) if params[:bus_id] 
    @object = @parent.photos.build
  end
  def edit
    load_object
  end
  def update
    load_object
    @object = update_attributes(params[:photo])
  end
  def create
    @object = Photo.new(params[:photo])
    @object.save
    @parent = Destination.find(params[:destination_id]) if params[:destination_id]
    @parent = Bus.find(params[:bus_id]) if params[:bus_id]
    @parent.photos << @object
    redirect_to :action => :index
  end
  def destroy
    load_object
    @object.destroy
    redirect_to :action => :index
  end

  def location_after_save
    admin_destination_photos_url(@destination)
  end
  
  def cover
    load_object
    @parent.title_photo_id = params[:id]
    @parent.save
    redirect_to :action => :index
  end


  protected
    def load_collection
      @parent = Destination.find(params[:destination_id]) if params[:destination_id]
      @parent = Bus.find(params[:bus_id]) if params[:bus_id]
      @collection = @parent.photos if @parent
    end
    def load_object
      @parent = Destination.find(params[:destination_id]) if params[:destination_id]
      @parent = Bus.find(params[:bus_id]) if params[:bus_id]
      @object = Photo.find(params[:id])
    end
end
end
