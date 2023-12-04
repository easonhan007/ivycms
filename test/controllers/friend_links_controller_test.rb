require "test_helper"

class FriendLinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @friend_link = friend_links(:one)
  end

  test "should get index" do
    get friend_links_url
    assert_response :success
  end

  test "should get new" do
    get new_friend_link_url
    assert_response :success
  end

  test "should create friend_link" do
    assert_difference("FriendLink.count") do
      post friend_links_url, params: { friend_link: { image: @friend_link.image, name: @friend_link.name, sorting: @friend_link.sorting, url: @friend_link.url } }
    end

    assert_redirected_to friend_link_url(FriendLink.last)
  end

  test "should show friend_link" do
    get friend_link_url(@friend_link)
    assert_response :success
  end

  test "should get edit" do
    get edit_friend_link_url(@friend_link)
    assert_response :success
  end

  test "should update friend_link" do
    patch friend_link_url(@friend_link), params: { friend_link: { image: @friend_link.image, name: @friend_link.name, sorting: @friend_link.sorting, url: @friend_link.url } }
    assert_redirected_to friend_link_url(@friend_link)
  end

  test "should destroy friend_link" do
    assert_difference("FriendLink.count", -1) do
      delete friend_link_url(@friend_link)
    end

    assert_redirected_to friend_links_url
  end
end
