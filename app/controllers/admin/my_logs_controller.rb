module Admin
	class MyLogsController < AdminController
    layout nil
    layout 'admin', :except => :zone
    def index
      params[:search] ||= {}
      @search = Log.metasearch(params[:search])
      @collection = @search.page(params[:page]).per_page(AppConfig[:admin_list_per_page])
    end
    def zone
      @no_log = '1'
      @collection ||= Log.last_operations(current_employee)
    end
	end
end

