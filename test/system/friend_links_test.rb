require "application_system_test_case"

class FriendLinksTest < ApplicationSystemTestCase
  setup do
    @friend_link = friend_links(:one)
  end

  test "visiting the index" do
    visit friend_links_url
    assert_selector "h1", text: "Friend links"
  end

  test "should create friend link" do
    visit friend_links_url
    click_on "New friend link"

    fill_in "Image", with: @friend_link.image
    fill_in "Name", with: @friend_link.name
    fill_in "Sorting", with: @friend_link.sorting
    fill_in "Url", with: @friend_link.url
    click_on "Create Friend link"

    assert_text "Friend link was successfully created"
    click_on "Back"
  end

  test "should update Friend link" do
    visit friend_link_url(@friend_link)
    click_on "Edit this friend link", match: :first

    fill_in "Image", with: @friend_link.image
    fill_in "Name", with: @friend_link.name
    fill_in "Sorting", with: @friend_link.sorting
    fill_in "Url", with: @friend_link.url
    click_on "Update Friend link"

    assert_text "Friend link was successfully updated"
    click_on "Back"
  end

  test "should destroy Friend link" do
    visit friend_link_url(@friend_link)
    click_on "Destroy this friend link", match: :first

    assert_text "Friend link was successfully destroyed"
  end
end
