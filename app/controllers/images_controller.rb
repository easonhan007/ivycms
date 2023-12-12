class ImagesController < AdminController
  before_action :set_image, only: %i[ destroy remove_from_product]

  # GET /images or /images.json
  def index
    @image = Image.new
    @pagy, @images = pagy Image.order('created_at DESC')
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # POST /images or /images.json
  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to images_path(), notice: "Image was successfully created." }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # turbo stream
  def create_from_product
    @image = Image.new(image_params)
    @saved = false

    if @image.save
      @msg = t("Image was successfully created.")
      @saved = true
    else
      @msg = t("Can not create image")
    end
  end

  # turbo stream
  def remove_from_product
    @image.destroy!
  end

  # DELETE /images/1 or /images/1.json
  def destroy
    @image.destroy!

    respond_to do |format|
      format.html { redirect_to images_url, notice: "Image was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def image_params
      params.require(:image).permit(:content, :alt)
    end
end
