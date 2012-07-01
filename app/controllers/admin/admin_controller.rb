module Admin
	class AdminController < ActionController::Base
		helper 'admin/base'
		helper 'search'
    helper 'admin/navigation'		
		layout 'admin'
	end
end
