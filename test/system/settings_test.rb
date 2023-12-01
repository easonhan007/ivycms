require "application_system_test_case"

class SettingsTest < ApplicationSystemTestCase
  setup do
    @setting = settings(:one)
  end

  test "visiting the index" do
    visit settings_url
    assert_selector "h1", text: "Settings"
  end

  test "should create setting" do
    visit settings_url
    click_on "New setting"

    fill_in "Copyright", with: @setting.copyright
    fill_in "Email", with: @setting.email
    check "Email active" if @setting.email_active
    fill_in "Email password", with: @setting.email_password
    fill_in "Email port", with: @setting.email_port
    fill_in "Email receiver", with: @setting.email_receiver
    fill_in "Email sender", with: @setting.email_sender
    fill_in "Email smtp", with: @setting.email_smtp
    fill_in "Email user name", with: @setting.email_user_name
    fill_in "Ga code", with: @setting.ga_code
    fill_in "Ico", with: @setting.ico
    fill_in "Logo", with: @setting.logo
    fill_in "Name", with: @setting.name
    fill_in "Phone", with: @setting.phone
    fill_in "Post per page", with: @setting.post_per_page
    fill_in "Product per page", with: @setting.product_per_page
    fill_in "Recommend per page", with: @setting.recommend_per_page
    fill_in "Share code", with: @setting.share_code
    fill_in "Skype", with: @setting.skype
    fill_in "Url", with: @setting.url
    fill_in "Whatsapp", with: @setting.whatsapp
    click_on "Create Setting"

    assert_text "Setting was successfully created"
    click_on "Back"
  end

  test "should update Setting" do
    visit setting_url(@setting)
    click_on "Edit this setting", match: :first

    fill_in "Copyright", with: @setting.copyright
    fill_in "Email", with: @setting.email
    check "Email active" if @setting.email_active
    fill_in "Email password", with: @setting.email_password
    fill_in "Email port", with: @setting.email_port
    fill_in "Email receiver", with: @setting.email_receiver
    fill_in "Email sender", with: @setting.email_sender
    fill_in "Email smtp", with: @setting.email_smtp
    fill_in "Email user name", with: @setting.email_user_name
    fill_in "Ga code", with: @setting.ga_code
    fill_in "Ico", with: @setting.ico
    fill_in "Logo", with: @setting.logo
    fill_in "Name", with: @setting.name
    fill_in "Phone", with: @setting.phone
    fill_in "Post per page", with: @setting.post_per_page
    fill_in "Product per page", with: @setting.product_per_page
    fill_in "Recommend per page", with: @setting.recommend_per_page
    fill_in "Share code", with: @setting.share_code
    fill_in "Skype", with: @setting.skype
    fill_in "Url", with: @setting.url
    fill_in "Whatsapp", with: @setting.whatsapp
    click_on "Update Setting"

    assert_text "Setting was successfully updated"
    click_on "Back"
  end

  test "should destroy Setting" do
    visit setting_url(@setting)
    click_on "Destroy this setting", match: :first

    assert_text "Setting was successfully destroyed"
  end
end
