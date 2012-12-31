module Admin
  class OrdersController < ResourceController
    new_action.after :new_params
    create.after :save_seats

    private
    def new_params
      if !@object.schedule_assignment && params[:assignment_id]
        sa = ScheduleAssignment.find(params[:assignment_id])
        @object.schedule_assignment = sa
        @object.schedule = sa.schedule
      end

      if params[:seats]
        @object.seats = params[:seats]
        rn = params[:seats].split(',').count
        while rn > 0 do
          item = @object.order_items.build
          item.num_adult = rn > 2 ? 2 : rn
          rn = rn - 2
        end
      end
    end
    def save_seats
      @object.save_seats
    end
  end
end
