module Admin
  class UserInfosController < ResourceController
    layout nil
    layout 'admin', :except => [:search, :brief]
	  def search
      @no_log = 1
	    r = []
	    UserInfo.where("full_name like '%#{params[:term]}%'").limit(100).order('full_name').each do |t|
	      r << {:value => "#{t.id}: #{t.full_name}", :id => t.id}
	    end
	    render :text => r.to_json
	  end
    def brief
      @no_log = 1
      @object = UserInfo.find(params[:id]) if params[:id]
    end
    def select
      if params[:id].to_i > 0
        load_object
      else
        @object = UserInfo.new
      end
    end

  end
  
end
