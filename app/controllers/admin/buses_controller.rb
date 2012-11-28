module Admin
  class BusesController < ResourceController
    def shifts
      @shifts = BusShift.where(:bus_id => params[:id])
    end
  end
end
