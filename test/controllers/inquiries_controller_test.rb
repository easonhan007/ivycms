require "test_helper"

class InquiriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inquiry = inquiries(:one)
  end

  test "should get index" do
    get inquiries_url
    assert_response :success
  end

  test "should get new" do
    get new_inquiry_url
    assert_response :success
  end

  test "should create inquiry" do
    assert_difference("Inquiry.count") do
      post inquiries_url, params: { inquiry: { content: @inquiry.content, email: @inquiry.email, ip: @inquiry.ip, name: @inquiry.name, phone: @inquiry.phone, product_id: @inquiry.product_id } }
    end

    assert_redirected_to inquiry_url(Inquiry.last)
  end

  test "should show inquiry" do
    get inquiry_url(@inquiry)
    assert_response :success
  end

  test "should get edit" do
    get edit_inquiry_url(@inquiry)
    assert_response :success
  end

  test "should update inquiry" do
    patch inquiry_url(@inquiry), params: { inquiry: { content: @inquiry.content, email: @inquiry.email, ip: @inquiry.ip, name: @inquiry.name, phone: @inquiry.phone, product_id: @inquiry.product_id } }
    assert_redirected_to inquiry_url(@inquiry)
  end

  test "should destroy inquiry" do
    assert_difference("Inquiry.count", -1) do
      delete inquiry_url(@inquiry)
    end

    assert_redirected_to inquiries_url
  end
end
