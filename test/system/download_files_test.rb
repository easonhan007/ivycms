require "application_system_test_case"

class DownloadFilesTest < ApplicationSystemTestCase
  setup do
    @download_file = download_files(:one)
  end

  test "visiting the index" do
    visit download_files_url
    assert_selector "h1", text: "Download files"
  end

  test "should create download file" do
    visit download_files_url
    click_on "New download file"

    fill_in "Desc", with: @download_file.desc
    fill_in "Name", with: @download_file.name
    click_on "Create Download file"

    assert_text "Download file was successfully created"
    click_on "Back"
  end

  test "should update Download file" do
    visit download_file_url(@download_file)
    click_on "Edit this download file", match: :first

    fill_in "Desc", with: @download_file.desc
    fill_in "Name", with: @download_file.name
    click_on "Update Download file"

    assert_text "Download file was successfully updated"
    click_on "Back"
  end

  test "should destroy Download file" do
    visit download_file_url(@download_file)
    click_on "Destroy this download file", match: :first

    assert_text "Download file was successfully destroyed"
  end
end
