class InquiriesController < AdminController
  before_action :set_inquiry, only: %i[ show edit ]

  # GET /inquiries or /inquiries.json
  def index
    @pagy, @inquiries = pagy Inquiry.order('created_at DESC')
  end

  # GET /inquiries/1 or /inquiries/1.json
  def show
  end

  # GET /inquiries/new
  def new
    @inquiry = Inquiry.new(name: 'Ivy Wong', email: 'me@ivywang.cc', 'phone': '123-456-789', content: 'for test')
  end


  # POST /inquiries or /inquiries.json
  def create
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.ip = request.remote_ip
    @setting = Setting.last()

    respond_to do |format|
      if @inquiry.save
        if @setting.can_inquiry?
          InquiryMailer.with(setting: @setting, inquiry: @inquiry, locale: @locale).client_sent_an_inquiry.deliver_now
        end

        format.html { redirect_to inquiries_url, notice: "Inquiry was successfully created." }
        format.json { render :show, status: :created, location: @inquiry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inquiry.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inquiry
      @inquiry = Inquiry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def inquiry_params
      params.require(:inquiry).permit(:name, :email, :phone, :content, :ip, :product_id)
    end
end
