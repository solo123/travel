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
    def seats      
      load_object
      if params[:operate] == 'hold'
        seats = []
        hid = rand(1000000)
        params[:seats].each do |seat_input|
          ei = current_employee.employee_info
          seat = @object.seats.build
          seat.seat_number = seat_input[0]
          seat.message = params[:message1]
          seat.customer_name = ei.nickname
          seat.telephone = ei.default_telephone
          seat.operator_id = current_employee.id
          seat.state = 'hold'
          seat.order_id = hid
          seat.save
          seats << seat.seat_number
        end
        @log_brief = "hold(#{seats.to_s})"
        @log_text = params.to_s
      elsif params[:operate] == 'release'
        seats = params[:seats].map{|s| s[0]}.join(',')
        @object.seats.where("seat_number in (#{seats})").delete_all
        @log_brief = "release(#{seats})"
        @log_text = params.to_s
      elsif params[:operate] == 'order_seats'
        seats = []
        params[:seats].each do |seat_input|
          seat = @object.seats.build
          seat.seat_number = seat_input[0]
          seat.order_id = params[:order_id]
          seat.state = 'order'
          seat.save
          seats << seat.seat_number
        end
        @log_brief = "order(#{seats.to_s})"
        @log_text = params.to_s
      end
    end

  end
end
