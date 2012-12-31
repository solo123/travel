module Admin
	class TodosController < ResourceController
    layout nil
    layout 'admin', :except => :zone
    def zone
      @no_log = 1
      @collection = Todo.where(:msg_to => current_employee.id).order('level desc, due_date desc').limit(10)
    end
	end
end

