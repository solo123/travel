module Admin
	class AdminController < ActionController::Base
    before_filter :authenticate_employee!
    after_filter :log_operation
		helper 'admin/base'
		helper 'search'
    helper 'admin/navigation'		
		layout 'admin'

    attr_writer :title 
    def title
  	  @title ||=  controller_name + ' ' + action_name
    end

    def log_operation
      return if defined? @no_log
      log = Log.new
      log.employee = current_employee
      log.current_sign_in_at = current_employee.current_sign_in_at
      log.last_sign_in_at = current_employee.last_sign_in_at
      log.sign_in_count = current_employee.sign_in_count
      log.page_url = request.headers['PATH_INFO']
      log.host = request.headers['SERVER_NAME']
      log.remote_addr = request.headers['REMOTE_ADDR']
      log.remote_host = request.headers['REMOTE_HOST']
      log.controller = controller_name
      log.action = action_name
      log.log_brief = @log_brief if defined? @log_brief
      log.log_text = @log_text if defined? @log_text
      log.level = 0
      if action_name == 'index'
        log.log_brief ||= 'list ' + log.controller
        log.level = 1
      elsif action_name == 'show'
        log.log_brief ||= 'view ' + log.controller + ':' + params[:id]
        log.level = 1
      elsif action_name == 'new' || action_name == 'edit'
        log.level = 0
      elsif action_name == 'create'
        log.log_brief ||= 'add new ' + log.controller
        log.level = 3
      elsif action_name == 'update'
        log.log_brief ||= 'edit ' + log.controller + ': ' + params[:id]
        if !log.log_text && defined? @object && !@object.changed.blank?
          log.log_text = @object.changes.to_s
        end
        log.level = 3
      elsif action_name == 'destroy'
        log.log_brief ||= 'hide/del ' + log.controller + ': ' + params[:id]
        log.log_text ||= params.to_s
        log.level = 4
      else
        log.log_brief ||= "#{log.action} #{log.controller}: #{params[:id]}"
        log.log_text ||= params.to_s       
        log.level = 3
      end
      log.save if log.level > 0
    end
	end
end
