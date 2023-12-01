require "test_helper"

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @setting = settings(:one)
  end

  test "should get index" do
    get settings_url
    assert_response :success
  end

  test "should get new" do
    get new_setting_url
    assert_response :success
  end

  test "should create setting" do
    assert_difference("Setting.count") do
      post settings_url, params: { setting: { copyright: @setting.copyright, email: @setting.email, email_active: @setting.email_active, email_password: @setting.email_password, email_port: @setting.email_port, email_receiver: @setting.email_receiver, email_sender: @setting.email_sender, email_smtp: @setting.email_smtp, email_user_name: @setting.email_user_name, ga_code: @setting.ga_code, ico: @setting.ico, logo: @setting.logo, name: @setting.name, phone: @setting.phone, post_per_page: @setting.post_per_page, product_per_page: @setting.product_per_page, recommend_per_page: @setting.recommend_per_page, share_code: @setting.share_code, skype: @setting.skype, url: @setting.url, whatsapp: @setting.whatsapp } }
    end

    assert_redirected_to setting_url(Setting.last)
  end

  test "should show setting" do
    get setting_url(@setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_setting_url(@setting)
    assert_response :success
  end

  test "should update setting" do
    patch setting_url(@setting), params: { setting: { copyright: @setting.copyright, email: @setting.email, email_active: @setting.email_active, email_password: @setting.email_password, email_port: @setting.email_port, email_receiver: @setting.email_receiver, email_sender: @setting.email_sender, email_smtp: @setting.email_smtp, email_user_name: @setting.email_user_name, ga_code: @setting.ga_code, ico: @setting.ico, logo: @setting.logo, name: @setting.name, phone: @setting.phone, post_per_page: @setting.post_per_page, product_per_page: @setting.product_per_page, recommend_per_page: @setting.recommend_per_page, share_code: @setting.share_code, skype: @setting.skype, url: @setting.url, whatsapp: @setting.whatsapp } }
    assert_redirected_to setting_url(@setting)
  end

  test "should destroy setting" do
    assert_difference("Setting.count", -1) do
      delete setting_url(@setting)
    end

    assert_redirected_to settings_url
  end
end
