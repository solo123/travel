module Admin
  class SpotsController < AdminController
    def index
      return @spots if @spots.present?
      if params[:tour_id]
        @tour = Tour.find(params[:tour_id])
        @spots = @tour.spots
      end
    end
    def edit
      @spot = Spot.find(params[:id])
      @tour = Tour.find(params[:tour_id])
      @spot.build_description if !@spot.description
    end
    def update
      @spot = Spot.find(params[:id])
      @spot.update_attributes(params[:infos_spot])
      @tour = Tour.find(params[:tour_id])
    end
    def new
      @spot = Spot.new
    end
    def create
      @spot = Spot.new
      @spot.tour_id = params[:tour_id].to_i
      @spot.update_attributes(params[:infos_spot])
    end
    def show
      @tour = Tour.find(params[:tour_id])
      @spot = Spot.find(params[:id])
      @tour.title_photo_id = @spot.destination.photo.id
      @tour.save
    end
  end
end