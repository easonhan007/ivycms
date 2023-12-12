class DownloadFilesController < AdminController
  before_action :set_download_file, only: %i[ show edit update destroy ]

  # GET /download_files or /download_files.json
  def index
    @pagy, @download_files = pagy DownloadFile.order('created_at DESC')
  end

  # GET /download_files/1 or /download_files/1.json
  def show
  end

  # GET /download_files/new
  def new
    @download_file = DownloadFile.new
  end

  # GET /download_files/1/edit
  def edit
  end

  # POST /download_files or /download_files.json
  def create
    @download_file = DownloadFile.new(download_file_params)

    respond_to do |format|
      if @download_file.save
        format.html { redirect_to download_file_url(@download_file), notice: "Download file was successfully created." }
        format.json { render :show, status: :created, location: @download_file }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @download_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /download_files/1 or /download_files/1.json
  def update
    respond_to do |format|
      if @download_file.update(download_file_params)
        format.html { redirect_to download_file_url(@download_file), notice: "Download file was successfully updated." }
        format.json { render :show, status: :ok, location: @download_file }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @download_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /download_files/1 or /download_files/1.json
  def destroy
    @download_file.destroy!

    respond_to do |format|
      format.html { redirect_to download_files_url, notice: "Download file was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_download_file
      @download_file = DownloadFile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def download_file_params
      params.require(:download_file).permit(:name, :desc, :content, :sorting)
    end
end
