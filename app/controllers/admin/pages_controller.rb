module Admin
  class PagesController < ResourceController
    def show
      if params[:id] == 'refresh'
        render :text => 'alert("refresh!");'
      end
    end
  end
end