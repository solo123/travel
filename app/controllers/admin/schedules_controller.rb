module Admin
  class SchedulesController < ResourceController
    def title
      if action_name == 'show'
        @title = 'Seats table'
      else
       super
      end 
    end 
    def generate
      @today = Date.today
      @default_days = AppConfig[:max_reservation_days].to_i
      @messages = []

      if params[:tour]
        tour = Tour.find(params[:tour])
        params[:ids].split(',').each do |day|
          tour.gen_schedule(day.to_date)
        end
        render :text => params[:tour] + ' done '
      else    
        Tour.where(:status => 1).each do |tour|
          gen_tour_schedule(tour, false)
        end
      end
    end
    
    def gen_tour_schedule(tour, gen_schedule)
      if tour.tour_setting && tour.tour_setting.is_auto_gen == 1 && (!tour.tour_setting.last_schedule_date || Date.parse(tour.tour_setting.last_schedule_date) < @today)
        tour_days = []
        days = tour.tour_setting.days_in_advance.to_i
        days = @default_days if days == 0
        (@today..@today + days).each do |day|
          tour_days << day 
        end
        if tour_days.length > 0
          ds = []
          tour_days.each do |d|
            range = d..d+1
            if !Schedule.exists?(:tour_id => tour.id, :departure_date => range)            
              Schedule.gen(tour,d) if gen_schedule
              ds << d
            end
          end
          @messages << [tour.id, tour.description.title, ds] if ds.count > 0
        end
      end
    end
    
    def orders
      load_object
      render :partial => 'orders', :object => @object.orders
    end
    def selected
      @object = Schedule.where(:tour_id => params[:tour_id]).where(:departure_date => params[:departure_date]).first
      if params[:page] == 'order'
        render 'admin/orders/selected'
      else
        render :text => @object ? "set_schedule(#{@object.id});" : "alert('not found');"
      end
    end

  end
end
