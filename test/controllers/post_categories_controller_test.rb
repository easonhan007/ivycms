require "test_helper"

class PostCategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get post_categories_index_url
    assert_response :success
  end

  test "should get new" do
    get post_categories_new_url
    assert_response :success
  end

  test "should get show" do
    get post_categories_show_url
    assert_response :success
  end

  test "should get edit" do
    get post_categories_edit_url
    assert_response :success
  end
end
