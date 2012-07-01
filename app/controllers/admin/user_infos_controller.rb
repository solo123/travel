module Admin
  class UserInfosController < ResourceController

	  def search
	    r = []
	    UserInfo.where("full_name like '%#{params[:term]}%'").limit(100).order('full_name').each do |t|
	      r << {:value => "#{t.id}: #{t.full_name}", :id => t.id}
	    end
	    render :text => r.to_json

	  end

  end
end
