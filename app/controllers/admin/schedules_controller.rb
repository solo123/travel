module Admin
  class SchedulesController < ResourceController
  
  def select
#    @datelist = @tour.schedules.map {|s| '[' + s.departure_date.strftime('%Y.%m.%d')+ ']'}.join()
#    @max_date = (@tour.schedules.last.departure_date.to_date - Date.today).to_i
  end
  def generate
    @today = Date.today
    @default_days = Spree::Config[:max_reservation_days].to_i
    @messages = []

    if params[:tour]
      tour = Infos::Tour.find(params[:tour])
      params[:ids].split(',').each do |day|
        tour.gen_schedule(day.to_date)
      end
      render :text => params[:tour] + ' done '
    else    
      Infos::Tour.where(:status => 1).each do |tour|
        gen_tour_schedule(tour, false)
      end
    end
  end
  
  def gen_tour_schedule(tour, gen_schedule)
      if tour.tour_setting && tour.tour_setting.is_auto_gen == 1 && (!tour.tour_setting.last_schedule_date || Date.parse(tour.tour_setting.last_schedule_date) < @today)
        tour_days = []
        days = tour.tour_setting.available_days.to_i
        days = @default_days if days == 0
        (@today..@today + days).each do |day|
          tour_days << day 
        end
        if tour_days.length > 0
          ds = []
          tour_days.each do |d|
            range = d..d+1
            if !Operates::Schedule.exists?(:tour_id => tour.id, :departure_date => range)            
              Operates::Schedule.gen(tour,d) if gen_schedule
              ds << d
            end
          end
          @messages << [tour.id, tour.title, ds] if ds.count > 0
        end
      end
  end
  
  def add_bus
    @operates_schedule = Operates::Schedule.find(params[:id])
    cnt = @operates_schedule.assignments.count + 1
    @operates_assignment = @operates_schedule.assignments.build
    @operates_assignment.title = "#{cnt}"
  end
  def update_bus
    @operates_schedule = Operates::Schedule.find(params[:id])
    @assignment = @operates_schedule.assignments.build
    @assignment.update_attributes(params[:operates_schedule_assignment])
    @total_seats = 57
    render 'update.js'
  end
  def update
    @operates_schedule = Operates::Schedule.find(params[:id])
    if params[:commit] == 'Update Price'
      @operates_schedule.price.update_attributes(params[:operates_schedule_price]) 
      render 'update_price.js'
      return
    else
      @operates_schedule.update_attributes(params[:operates_schedule])
      @assignment = @operates_schedule.assignments.last
      @total_seats = 57
    end
  end
  def hold_seats
    @assignment = Operates::ScheduleAssignment.find(params[:assignment_id])
    params[:seats].split(',').each do |sn|
      seat = @assignment.seats.build
      seat.seat_number = sn
      seat.message1 = params[:message1]
      user_info = Infos::UserInfo.where(:user_id => current_user.id).first
      employee = Infos::Employee.where(:user_info_id => user_info.id).first
      seat.message2 = "#{employee.nickname}<br />137-234-23434"
      seat.state = 'hold'
      seat.save
    end
  end
  def release_seats
    @assignment = Operates::ScheduleAssignment.find(params[:assignment_id])
    @seats = []
    params[:seats].split(',').each do |sn|
      seat = @assignment.seats.where(:seat_number => sn).first
      if seat && seat.state == 'hold'
        @seats << seat.seat_number
        Operates::BusSeat.delete(seat.id)
      end
    end
  end
  def new_order
    current_userinfo = Infos::UserInfo.find_by_user_id(current_user.id)
    current_employee = Infos::Employee.find_by_user_info_id(current_userinfo.id)
    @assignment = Operates::ScheduleAssignment.find(params[:assignment_id])
    schedule = @assignment.schedule
    rooms = params[:rooms].split(',')
    order = Operates::Order.new
    order.order_source_type = 'Operates::Schedule'
    order.order_source_id = schedule.id
    order.order_method = 'counter'
    order.state = 'new'

    order = Operates::Order.new
    order.order_source_type = 'Operates::Schedule'
    order.order_source_id = schedule.id
    order.state = 'new'
    order.order_method = 'counter'
    rooms.each do |num|
      item = order.items.build
      item.num_adult = item.num_total = num.to_i
      item.amount = schedule.price.room_price(num)
    end
    order.build_customer
    order.build_order_operate
    order.order_operate.created_by = current_employee.id
    order.order_operate.last_operator = current_employee.id
    order.save        
  end
  
  def search
    r = []
    Tour.where("title like '%#{params[:term]}%'").limit(100).order('title').each do |t|
      r << {:value => "#{t.id}: #{t.title}/#{t.title_cn}", :id => t.id}
    end
    render :text => r.to_json

  end

  def selected
    s = Schedule.where(:tour_id => params[:tour_id]).where(:departure_date => params[:departure_date]).first
    render :text => s ? "set_schedule(#{s.id});" : "alert('not found');"
  end

end
end