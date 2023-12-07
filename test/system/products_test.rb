require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
  end

  test "visiting the index" do
    visit products_url
    assert_selector "h1", text: "Products"
  end

  test "should create product" do
    visit products_url
    click_on "New product"

    check "Active" if @product.active
    fill_in "Category", with: @product.category_id
    fill_in "Content", with: @product.content
    fill_in "Desc", with: @product.desc
    fill_in "Hot", with: @product.hot
    fill_in "Key", with: @product.key
    fill_in "Meta title", with: @product.meta_title
    fill_in "Model string", with: @product.model_string
    fill_in "Name", with: @product.name
    check "New arrive" if @product.new_arrive
    fill_in "Price", with: @product.price
    fill_in "Sorting", with: @product.sorting
    fill_in "Specs", with: @product.specs
    fill_in "Url", with: @product.url
    click_on "Create Product"

    assert_text "Product was successfully created"
    click_on "Back"
  end

  test "should update Product" do
    visit product_url(@product)
    click_on "Edit this product", match: :first

    check "Active" if @product.active
    fill_in "Category", with: @product.category_id
    fill_in "Content", with: @product.content
    fill_in "Desc", with: @product.desc
    fill_in "Hot", with: @product.hot
    fill_in "Key", with: @product.key
    fill_in "Meta title", with: @product.meta_title
    fill_in "Model string", with: @product.model_string
    fill_in "Name", with: @product.name
    check "New arrive" if @product.new_arrive
    fill_in "Price", with: @product.price
    fill_in "Sorting", with: @product.sorting
    fill_in "Specs", with: @product.specs
    fill_in "Url", with: @product.url
    click_on "Update Product"

    assert_text "Product was successfully updated"
    click_on "Back"
  end

  test "should destroy Product" do
    visit product_url(@product)
    click_on "Destroy this product", match: :first

    assert_text "Product was successfully destroyed"
  end
end
