module Admin
	class BusSeatsController < AdminController
    layout 'empty' 
    
    def index
      @no_log = 1
    end

	end
end
