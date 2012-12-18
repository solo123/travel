module Admin
  class DestinationsController < ResourceController
    new_action.after :add_description
    edit.after :add_description

    def show
      load_object
    end

    protected
    def load_collection
      params[:search] ||= {}
      @search = Destination.metasearch(params[:search])
      @collection = @search.page(params[:page]).includes([:city]).per_page(AppConfig[:admin_list_per_page])
    end

    def add_description
      unless @object.description
        @object.build_description
      end
    end

  end
end
