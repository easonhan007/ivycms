require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference("Product.count") do
      post products_url, params: { product: { active: @product.active, category_id: @product.category_id, content: @product.content, desc: @product.desc, hot: @product.hot, key: @product.key, meta_title: @product.meta_title, model_string: @product.model_string, name: @product.name, new_arrive: @product.new_arrive, price: @product.price, sorting: @product.sorting, specs: @product.specs, url: @product.url } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { active: @product.active, category_id: @product.category_id, content: @product.content, desc: @product.desc, hot: @product.hot, key: @product.key, meta_title: @product.meta_title, model_string: @product.model_string, name: @product.name, new_arrive: @product.new_arrive, price: @product.price, sorting: @product.sorting, specs: @product.specs, url: @product.url } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
