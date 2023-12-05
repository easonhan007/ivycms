class FriendLinksController < AdminController
  before_action :set_friend_link, only: %i[ show edit update destroy show_modal ]

  # GET /friend_links or /friend_links.json
  def index
    @friend_link = FriendLink.new
    @friend_links = FriendLink.order('sorting ASC')
  end

  # GET /friend_links/1 or /friend_links/1.json
  def show
  end

  def show_modal
  end

  # GET /friend_links/new
  def new
    @friend_link = FriendLink.new
  end

  # GET /friend_links/1/edit
  def edit
  end

  # POST /friend_links or /friend_links.json
  def create
    @friend_link = FriendLink.new(friend_link_params)

    respond_to do |format|
      if @friend_link.save
        format.html { redirect_to friend_links_path, notice: t("Friend link was successfully created.") }
        format.json { render :show, status: :created, location: @friend_link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friend_links/1 or /friend_links/1.json
  def update
    respond_to do |format|
      if @friend_link.update(friend_link_params)
        format.html { redirect_to friend_links_url(@friend_link), notice: t("Friend link was successfully updated.") }
        format.json { render :show, status: :ok, location: @friend_link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friend_links/1 or /friend_links/1.json
  def destroy
    @friend_link.destroy!

    respond_to do |format|
      format.html { redirect_to friend_links_url, notice: t("Friend link was successfully destroyed.") }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend_link
      @friend_link = FriendLink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friend_link_params
      params.require(:friend_link).permit(:name, :url, :sorting, :image)
    end
end
