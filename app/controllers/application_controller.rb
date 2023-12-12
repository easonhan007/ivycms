class ApplicationController < ActionController::Base
	include Pagy::Backend
	around_action :switch_locale

	def default_url_options
		{ locale: I18n.locale }
	end

	def switch_locale(&action)
	  locale = params[:locale] || I18n.default_locale
		@locale = locale
	  I18n.with_locale(locale, &action)
	end

end
