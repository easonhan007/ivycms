class ApplicationController < ActionController::Base
	include Pagy::Backend
	around_action :switch_locale
	before_action :load_limitation

	def default_url_options
		{ locale: I18n.locale }
	end

	private 
		def switch_locale(&action)
		  locale = params[:locale] || I18n.default_locale
			@locale = locale
		  I18n.with_locale(locale, &action)
		end

		def load_limitation()
			@limitation = Rails.application.config_for(:limitation)
		end

end
