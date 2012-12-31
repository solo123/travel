class ApplicationController < ActionController::Base
	before_filter :set_locale
	helper_method :title
	helper_method 'title='
  layout :layout_by_resource

  # can be used in views as well as controllers.
  # e.g. <% title = 'This is a custom title for this view' %>
  attr_writer :title

  def title
  	@title ||= AppConfig[:site_name]
  end

	def set_locale
	  I18n.locale = extract_locale_from_tld || I18n.default_locale
	end
	def extract_locale_from_tld
	  parsed_locale = request.host.split('.').first
	  I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale  : nil
	end
  def after_sign_in_path_for(resource)
    if resource.is_a?(Employee)
      log = Log.new
      log.employee = resource
      log.current_sign_in_at = resource.current_sign_in_at
      log.last_sign_in_at = resource.last_sign_in_at
      log.sign_in_count = resource.sign_in_count
      log.page_url = request.headers['PATH_INFO']
      log.host = request.headers['SERVER_NAME']
      log.remote_addr = request.headers['REMOTE_ADDR']
      log.remote_host = request.headers['REMOTE_HOST']
      log.controller = controller_name
      log.action = action_name
      log.log_text = request.headers.to_s
      log.log_brief = 'view ' + log.controller + '#' + log.action 
      log.level = 2
      log.save
      '/admin'
    else
      super
    end
  end
  def layout_by_resource
    if devise_controller? && resource_name == :employee
      "login"
    else
      "application"
    end
  end
end
