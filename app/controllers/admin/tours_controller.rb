module Admin
  class ToursController < ResourceController

    def destinations
    end
    def get_schedules
      load_object
      datelist = @object.schedules.map {|s| '"' + s.departure_date.strftime('%Y.%m.%d')+ '"'}.join(',')
      render :text => "[" + datelist + "]"
    end
    def show
      if params[:id] == 'refresh_icons'
        Tour.where(:title_photo_id => nil).each do |tour|
          spot = tour.spots.where(:visit_day => 1).first
          if spot && spot.destination && spot.destination.photo
            tour.title_photo = spot.destination.photo
            tour.save
          end
        end
        redirect_to :action => :index
        return
      elsif params[:id] == 'icons'
        @tours = Tour.visible
        render 'icons'
        return
      else
        load_object
      end
    end

    def dates
      tour = Tour.find(params[:id])
      @datelist = []
      @max_date = Date.today + 30
      if tour.schedules.count > 0
        @datelist = tour.schedules.map {|s| s.departure_date.strftime('%Y.%m.%d')}.join(',')
        @max_date = (tour.schedules.last.departure_date.to_date - Date.today).to_i
      end      
    end

    def search
      r = []
      Tour.joins(:description).where("descriptions.title like '%#{params[:term]}%'").limit(100).order('title').each do |t|
        r << {:value => "#{t.id}: #{t.description.title}/#{t.description.title_cn}", :id => t.id}
      end
      render :text => r.to_json      
    end
    protected

  end
end
