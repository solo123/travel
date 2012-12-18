module Admin
  class SpotsController < ResourceController
    create.before :add_tour_id

    def show
      # set tour icon
      load_object
      @object.tour.title_photo = @object.destination.title_photo
      @object.tour.save
    end

    def add_tour_id
      @object.tour_id = params[:tour_id].to_i
    end
    private
      def load_collection
        @tour = Tour.find(params[:tour_id])
        @collection = @tour.spots
      end 
      def load_object
        @object = Spot.find(params[:id])
      end
 
  end
end
