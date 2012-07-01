class DestinationsController < ApplicationController

  def index
    @destinations = Destination.visible
  end
  def show
    @destination = Destination.find(params[:id])
    tours = Spot.select('DISTINCT tour_id').where(:destination_id => @destination.id).collect{|spot| spot.tour_id}
    @related_tours = Tour.find(tours)
  end
end