class HomeController < ApplicationController
  def index
    @setting = Setting.last
    @navigations = Navigation
    @banners = Banner.with_limitation(@limitation[:homepage][:banner])

    @product_categories = ProductCategory.build()
    @hot_products = Product.hot(@setting.product_per_page || @limitation[:homepage][:hot_products])
    @recommend_products = Product.hot(@setting.recommend_per_page || @limitation[:homepage][:recommend_products])
    @new_arrive_products = Product.new_arrive(@setting.new_arrive_per_page || @limitation[:homepage][:new_arrive_products])
  end
end
