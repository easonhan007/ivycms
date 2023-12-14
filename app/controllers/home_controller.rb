class HomeController < ApplicationController
  def index
    @setting = Setting.last
    @navigations = Navigation.with_limitation(@limitation[:global][:navigation_count])
    @banners = Banner.with_limitation(@limitation[:homepage][:banner])
    if @banners.blank?
      @banners = [Banner.new(name: 'default', url: @limitation[:homepage][:default_banner_url])]
    end

    @product_categories = ProductCategory.build()
    @hot_products = Product.hot(@setting.product_per_page || @limitation[:homepage][:hot_products])
    @recommend_products = Product.hot(@setting.recommend_per_page || @limitation[:homepage][:recommend_products])
    @new_arrive_products = Product.new_arrive(@setting.new_arrive_per_page || @limitation[:homepage][:new_arrive_products])

    @latest_posts = Post.latest(@limitation[:homepage][:post_count])
    @post_default_img = @limitation[:post][:default_img]

    @friend_links = FriendLink.with_limitation(@limitation[:homepage][:friend_link_count])
    
    @inquiry = Inquiry.new()

  end

  def inquiry
    inquiry_params = params.require(:inquiry).permit(:name, :email, :phone, :content, :ip, :product_id)
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.ip = request.remote_ip
    @setting = Setting.last()

    respond_to do |format|
      if @inquiry.save
        if @setting.can_inquiry?
          InquiryMailer.with(setting: @setting, inquiry: @inquiry, locale: @locale).client_sent_an_inquiry.deliver_now
        end
        @msg = t('Your inquiry has been successfully sent.')
      else
        @msg = t("Can not send your inquiry")
      end
      format.turbo_stream {}
    end
  end

end
