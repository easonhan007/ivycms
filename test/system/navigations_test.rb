require "application_system_test_case"

class NavigationsTest < ApplicationSystemTestCase
  setup do
    @navigation = navigations(:one)
  end

  test "visiting the index" do
    visit navigations_url
    assert_selector "h1", text: "Navigations"
  end

  test "should create navigation" do
    visit navigations_url
    click_on "New navigation"

    check "Dropdown" if @navigation.dropdown
    fill_in "Link", with: @navigation.link
    fill_in "Name", with: @navigation.name
    fill_in "Sorting", with: @navigation.sorting
    click_on "Create Navigation"

    assert_text "Navigation was successfully created"
    click_on "Back"
  end

  test "should update Navigation" do
    visit navigation_url(@navigation)
    click_on "Edit this navigation", match: :first

    check "Dropdown" if @navigation.dropdown
    fill_in "Link", with: @navigation.link
    fill_in "Name", with: @navigation.name
    fill_in "Sorting", with: @navigation.sorting
    click_on "Update Navigation"

    assert_text "Navigation was successfully updated"
    click_on "Back"
  end

  test "should destroy Navigation" do
    visit navigation_url(@navigation)
    click_on "Destroy this navigation", match: :first

    assert_text "Navigation was successfully destroyed"
  end
end
