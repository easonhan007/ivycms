class HomeController < ApplicationController
  before_action :set_layout_data
  before_action :get_post_default_image, only: %w(index news about posts contact post)
  before_action :validate_cloudflare_turnstile, only: %w[inquiry]
  rescue_from RailsCloudflareTurnstile::Forbidden do
    @msg = t('Can not send your inquiry')
    redirect_to root_path, notice: @msg
  end

  def index
    @hot_products = Product.hot(@setting.product_per_page || @limitation[:homepage][:hot_products])
    @recommend_products = Product.recommend(@setting.recommend_per_page || @limitation[:homepage][:recommend_products])
    @new_arrive_products = Product.new_arrive(@setting.new_arrive_per_page || @limitation[:homepage][:new_arrive_products])
    @featured_categories = ProductCategory.order('sorting ASC').limit(@limitation[:homepage][:featured_categories])

    @latest_posts = Post.latest(@setting.latest_post_count || @limitation[:homepage][:post_count])
  end

  def inquiry
    inquiry_params = params.require(:inquiry).permit(:name, :email, :phone, :content, :ip, :product_id, :bluescript)
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.ip = request.remote_ip
    @setting = Setting.last()

    if @inquiry.save
      if @setting.can_inquiry?
        InquiryMailer.with(setting: @setting, inquiry: @inquiry, locale: @locale).client_sent_an_inquiry.deliver_later
      end
      @msg = t('Your inquiry has been successfully sent.')
    else
      @msg = t("Can not send your inquiry")
    end
    redirect_to thank_you_path, notice: @msg
  end

  def thank_you
  end

  def s_page
  end

  def product
    if params[:product].to_i.eql?(0)
      condition = {url: params[:product]}
    else
      condition = {id: params[:product].to_i}
    end#if
    @product = Product.where(condition).take()
    @category = @product.category.path_to_category_arr()
    @related = @product.category.products.where("id != ?", @product.id).order("sorting ASC").limit(@limitation[:product][:related_count])
    logger.info(@related)
  end

  def category
    if params[:category].to_i.eql?(0)
      condition = {url: params[:category]}
    else
      condition = {id: params[:category].to_i}
    end#if

    @category = ProductCategory.where(condition).take()
    @categories = ProductCategory.order("sorting ASC").limit(@limitation[:product][:category_count])
    @pagy, @products = pagy @category.products.order("sorting ASC")
    render "home/products"
  end

  def products
    @categories = ProductCategory.order("sorting ASC").limit(@limitation[:product][:category_count])
    @pagy, @products = pagy Product.includes(:category).order("sorting ASC")
  end

  def about
    @category = PostCategory.where(name: 'About Us').take()
    render 'home/post_category'
  end

  def contact
    @category = PostCategory.where(name: 'Contact Us').take()
    render 'home/post_category'
  end

  def news
    @category = PostCategory.where(name: 'News').take()
    @pagy, @resouces = pagy @category.posts.order('created_at DESC')
    render 'home/post_category'
  end

  def posts
    @category = PostCategory.where(name: 'Blog').take()
    @pagy, @resouces = pagy @category.posts.published.order('created_at DESC')
    render 'home/post_category'
  end

  def downloads
    @pagy, @download_files = pagy DownloadFile.order('created_at DESC')
  end

  def post
    if numberic? params[:post]
      condition = {id: params[:post].to_i}
    else
      condition = {display_title: params[:post]}
    end#if
    @post = Post.published.where(condition).take()
  end

  def search
    if params[:kw].present?
      @categories = ProductCategory.order("sorting ASC").limit(@limitation[:product][:category_count])
      @pagy, @products = pagy Product.includes(:category).where("name like ?", "%#{params[:kw]}%").order("sorting ASC")
      render "home/products"
    else
      redirect_to root_path
    end
  end

  def sitemap
    defualt_order = 'created_at DESC'

    @posts = Post.order(defualt_order)
    @products = Product.active.order(defualt_order)
    @product_categories = ProductCategory.active.order(defualt_order)
    @post_categories = PostCategory.active.order(defualt_order)

    @about = PostCategory.where(name: 'About Us').take()
    @contact = PostCategory.where(name: 'Contact Us').take()
  end

  private 
    def set_layout_data
      @product_categories = ProductCategory.build()
      @navigations = Navigation.with_limitation(@limitation[:global][:navigation_count])
      @friend_links = FriendLink.with_limitation(@limitation[:homepage][:friend_link_count])
      @inquiry = Inquiry.new()

      @banners = Banner.with_limitation(@limitation[:homepage][:banner])
      if @banners.blank?
        @banners = [Banner.new(image: 'default', url: @limitation[:homepage][:default_banner_url])]
      end

    end

    def get_post_default_image
      @post_default_img = @limitation[:post][:default_img]
    end

    def numberic?(the_string)
      Integer(the_string) rescue false
    end


end
