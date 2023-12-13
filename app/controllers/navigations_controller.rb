class NavigationsController < AdminController
  before_action :set_navigation, only: %i[ show edit update destroy ]

  # GET /navigations or /navigations.json
  def index
    @navigations = Navigation.with_limitation(@limitation[:global][:navigation_count])
  end

  # GET /navigations/1 or /navigations/1.json
  def show
  end

  # GET /navigations/new
  def new
    @navigation = Navigation.new
  end

  # GET /navigations/1/edit
  def edit
  end

  # POST /navigations or /navigations.json
  def create
    @navigation = Navigation.new(navigation_params)

    respond_to do |format|
      if @navigation.save
        format.html { redirect_to navigation_url(@navigation), notice: "Navigation was successfully created." }
        format.json { render :show, status: :created, location: @navigation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @navigation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /navigations/1 or /navigations/1.json
  def update
    respond_to do |format|
      if @navigation.update(navigation_params)
        format.html { redirect_to navigation_url(@navigation), notice: "Navigation was successfully updated." }
        format.json { render :show, status: :ok, location: @navigation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @navigation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /navigations/1 or /navigations/1.json
  def destroy
    @navigation.destroy!

    respond_to do |format|
      format.html { redirect_to navigations_url, notice: "Navigation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_navigation
      @navigation = Navigation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def navigation_params
      params.require(:navigation).permit(:name, :link, :dropdown, :sorting)
    end
end
