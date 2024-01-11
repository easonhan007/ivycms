class SettingsController < AdminController
  before_action :set_setting, only: %i[ edit update index]

  def index
    redirect_to edit_setting_path(@setting)
  end

  # GET /settings/1/edit
  def edit
  end

  # PATCH/PUT /settings/1 or /settings/1.json
  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to setting_url(@setting), notice: "Setting was successfully updated." }
        format.json { render :show, status: :ok, location: @setting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
      if params[:id]
        @setting = Setting.find(params[:id])
      else
        @setting = Setting.last
      end 
    end

    # Only allow a list of trusted parameters through.
    def setting_params
      params.require(:setting).permit(:name, :url, :logo, :ico, :copyright, :email, :skype, 
        :whatsapp, :phone, :product_per_page, :post_per_page, :recommend_per_page, 
        :share_code, :email_user_name, :email_passwd, :email_port, :email_smtp, :theme,
        :email_receiver, :email_sender, :email_active, :ga_code, :new_arrive_per_page,
        :email_auto_ssl, :email_authentication, :seo_meta_title, :seo_description, :seo_keywords,
        :raw_block, :cf_secret_key, :cf_site_key, :tawk_code, :g_tag_head, :g_tag_body,
        :latest_post_count)
    end
end
