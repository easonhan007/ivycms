class ApplicationController < ActionController::Base
	include Pagy::Backend
	around_action :switch_locale
	before_action :load_limitation, :set_template_dir, :setup_turnstile

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

		def set_template_dir()
      @setting = Setting.last
			if not %w[admin sessions].include?(controller_name)
				if @setting.theme.present?
					prepend_view_path Rails.root.join("app", "views", @setting.theme)
				end #if
			end #if
		end

		def setup_turnstile()
			@turnstile = false
			if @setting.cf_secret_key.present? and @setting.cf_site_key.present?
				logger.info("x" * 10)
				logger.info("set the turntitle key")
				@turnstile = true
				RailsCloudflareTurnstile.configure do |c|
					c.site_key = @setting.cf_site_key
					c.secret_key = @setting.cf_secret_key
					c.fail_open = true
				end 
			end #if
		end

end
