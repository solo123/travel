module Admin
  class OrdersController < ResourceController
    new_action.after :new_params

    private
    def new_params
      if !@object.order_source && params[:assignment_id]
        sa = ScheduleAssignment.find(params[:assignment_id])
        @object.order_source = sa.schedule
      end

      if params[:seats]
        rn = params[:seats].split(',').count
        while rn > 0 do
          item = @object.order_items.build
          item.num_adult = rn > 2 ? 2 : rn
          rn = rn - 2
        end
      end
    end
  end
end
