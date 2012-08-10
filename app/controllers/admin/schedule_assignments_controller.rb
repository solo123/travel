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
      elsif params[:operate] == 'order_seats'
        params[:seats].each do |seat_input|
          seat = @object.seats.build
          seat.seat_number = seat_input[0]
          seat.order_id = params[:order_id]
          seat.message1 = ""
          seat.message2 = "!!order!!"
          seat.state = 'order'
          seat.save
        end
      end
    end

  end
end
