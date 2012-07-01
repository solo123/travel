class ApplicationController < ActionController::Base
	before_filter :set_locale

	helper_method :title
	helper_method 'title='

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
end
