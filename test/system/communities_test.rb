require "application_system_test_case"

class CommunitiesTest < ApplicationSystemTestCase
  setup do
    login_as users(:john)
    @cooking_community = communities(:cooking)
    @cars_community = communities(:cars)
  end

  test "Creating a new Community" do
    visit root_path

    click_on "New Community"
    assert_selector "h1", text: 'New Community'

    fill_in "Description", with: @cooking_community.description

    click_on "Create Community"

    assert_text "Handle can't be blank."

    fill_in "Handle", with: @cooking_community.handle
    fill_in "Description", with: @cooking_community.description

    click_on "Create Community"

    assert_text "Handle must be unique."

    fill_in "Handle", with: "       #{@cooking_community.handle}      "

    click_on "Create Community"

    assert_text "Handle must be unique."

    fill_in "Handle", with: "casual-woodworking"
    fill_in "Description", with: "For wood workers and beyond"

    click_on "Create Community"

    assert_text "c/casual-woodworking"
    assert_text "For wood workers and beyond"
  end

  test "Showing a community" do
    visit root_path

    click_on @cooking_community.handle

    assert_text @cooking_community.handle
    assert_text @cooking_community.description

    assert_text @cooking_community.posts.first.caption
    assert_no_text @cars_community.posts.first.caption
  end

  test "Join a community" do
    visit root_path

    click_on @cooking_community.handle

    click_on "Join"
    assert_button "Joined"
  end

  test "Quit a community" do
    visit root_path

    click_on @cars_community.handle

    click_on "Joined"
    assert_button "Join"
  end
end
