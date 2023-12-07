class ProductCategoriesController < AdminController
  before_action :set_product_category, only: %i[ show edit update destroy show_modal toggle_status]

  # GET /product_categories or /product_categories.json
  def index
    @product_categories = ProductCategory.build()
    @all_categories = ProductCategory.build_ignore_status()
  end

  # GET /product_categories/1 or /product_categories/1.json
  def show
  end

  def show_modal
  end

  # GET /product_categories/new
  def new
    @product_category = ProductCategory.new
  end

	def new_a_child
    @parent = ProductCategory.find(params[:id])
    @product_category = ProductCategory.new(parent_id: @parent.id)
		render :new
	end

	def toggle_status
		if @product_category.active
			@product_category.inactive_with_children()
		else
			@product_category.active_with_children()
		end
		redirect_to product_categories_path, notice: t("Status toggled successfully.")
	end

  # GET /product_categories/1/edit
  def edit
  end

  # POST /product_categories or /product_categories.json
  def create
		if not product_category_params[:parent_id].blank?
			parent_id = product_category_params.delete(:parent_id)
	    @parent = ProductCategory.find(parent_id)
			pp(product_category_params.to_h)
			@product_category = @parent.create_child(**product_category_params.to_h)
			if @product_category.persisted?
				redirect_to product_categories_path, notice: t("Product category was successfully created.")
			else
				render :new, status: :unprocessable_entity
			end
		else
	    @product_category = ProductCategory.new(product_category_params)

	    respond_to do |format|
	      if @product_category.save
	        format.html { redirect_to product_categories_path, notice: t("Product category was successfully created.") }
	        format.json { render :show, status: :created, location: @product_category }
	      else
	        format.html { render :new, status: :unprocessable_entity }
	        format.json { render json: @product_category.errors, status: :unprocessable_entity }
	      end
	    end
		end #if
  end

  # PATCH/PUT /product_categories/1 or /product_categories/1.json
  def update
    respond_to do |format|
      if @product_category.update(product_category_params)
        format.html { redirect_to product_categories_path, notice: t("Product category was successfully updated.") }
        format.json { render :show, status: :ok, location: @product_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_categories/1 or /product_categories/1.json
  def destroy
    @product_category.destroy!

    respond_to do |format|
      format.html { redirect_to product_categories_path, notice: t("Product category was successfully destroyed.") }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_category
      @product_category = ProductCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_category_params
      params.require(:product_category).permit(:level, :path, :name, :key, :description, :image, :url, :sorting, :active, :parent_id)
    end
end
