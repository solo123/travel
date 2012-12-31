module Admin
	class LogsController < AdminController
    def index
      params[:search] ||= {}
      @search = Log.metasearch(params[:search])
      @collection = @search.page(params[:page]).per_page(AppConfig[:admin_list_per_page])
    end
	end
end
