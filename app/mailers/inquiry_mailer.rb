class InquiryMailer < ApplicationMailer
	before_action :set_sender_and_receiver
	before_action :set_delivery_options

  default to:       -> { @receiver },
          from:     -> { @sender }

  def client_sent_an_inquiry()
		# mail(subject: t("Received a new inquiry"), delivery_method_options: @delivery_options)
		mail(subject: t("Received a new inquiry"))
  end

  private
    def set_sender_and_receiver
			@setting = params[:setting]
			@inquiry = params[:inquiry]
      @sender = @setting.email_sender
      @receiver = @setting.email_receiver
			@locale = params[:locale]
    end

		def set_delivery_options
			@delivery_options = { user_name: @setting.email_user_name,
	                         password: @setting.email_passwd,
	                         port: @setting.email_port.to_i,
													 enable_starttls_auto: @setting.email_auto_ssl,
	                         address: @setting.email_smtp }
			
			@delivery_options[:authentication] = 'plain' if @setting.email_authentication
		 	mail.delivery_method.settings.merge!(@delivery_options)
		end
end
