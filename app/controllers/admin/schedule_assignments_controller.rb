module Admin
  class ScheduleAssignmentsController < ResourceController
    def destroy
      load_object
      if @object.seats.count == 0
        @object.delete
      else
        flash[:alert] = 'not empty'
      end
    end
    def hold_seats
      load_object
      params[:seats].each do |seat_input|
        seat = @object.seats.build
        seat.seat_number = seat_input[0]
        seat.message1 = params[:message1]
        #employee = current_employee
        seat.message2 = "#employee.nickname<br />137-234-23434"
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
 
  end
end
