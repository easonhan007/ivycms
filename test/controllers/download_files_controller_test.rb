require "test_helper"

class DownloadFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @download_file = download_files(:one)
  end

  test "should get index" do
    get download_files_url
    assert_response :success
  end

  test "should get new" do
    get new_download_file_url
    assert_response :success
  end

  test "should create download_file" do
    assert_difference("DownloadFile.count") do
      post download_files_url, params: { download_file: { desc: @download_file.desc, name: @download_file.name } }
    end

    assert_redirected_to download_file_url(DownloadFile.last)
  end

  test "should show download_file" do
    get download_file_url(@download_file)
    assert_response :success
  end

  test "should get edit" do
    get edit_download_file_url(@download_file)
    assert_response :success
  end

  test "should update download_file" do
    patch download_file_url(@download_file), params: { download_file: { desc: @download_file.desc, name: @download_file.name } }
    assert_redirected_to download_file_url(@download_file)
  end

  test "should destroy download_file" do
    assert_difference("DownloadFile.count", -1) do
      delete download_file_url(@download_file)
    end

    assert_redirected_to download_files_url
  end
end
