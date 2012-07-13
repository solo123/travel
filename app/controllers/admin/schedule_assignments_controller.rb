module Admin
  class ScheduleAssignmentsController < ResourceController
    create.after :add_shift
    update.after :add_shift

    def add_shift
      @object.add_shift
    end
    def destroy
      load_object
      if @object.seats.count == 0
        @object.del_shift
        @object.delete
      else
        flash[:alert] = 'not empty'
      end
    end
    def seats      
      load_object
      if params[:operate] == 'hold'
        params[:seats].each do |seat_input|
          seat = @object.seats.build
          seat.seat_number = seat_input[0]
          seat.message1 = params[:message1]
          #employee = current_employee
          seat.message2 = "#employee.nickname<br />137-234-23434"
          seat.state = 'hold'
          seat.save
        end
      elsif params[:operate] == 'release'
        seats = params[:seats].map{|s| s[0]}.join(',')
        @object.seats.where("seat_number in (#{seats})").delete_all
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
