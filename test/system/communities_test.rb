require "application_system_test_case"

class CommunitiesTest < ApplicationSystemTestCase
  setup do
    login_as users(:john)
    @cooking_community = communities(:cooking)
  end

  test "Creating a new Community" do
    visit posts_path
    assert_selector "h1", text: "Posts"

    click_on "New Community"
    assert_selector "h1", text: 'New Community'

    fill_in "Name", with: "Casual Woodworking"
    fill_in "Description", with: "For wood workers and beyond"

    click_on "Create Community"

    assert_text "Casual Woodworking"
    assert_text "casual-woodworking"
    assert_text "For wood workers and beyond"
  end

  test "Showing a Community" do
    visit posts_path
    assert_selector "h1", text: "Posts"

    click_on @cooking_community.handle

    assert_text @cooking_community.handle
    assert_text @cooking_community.name
    assert_text @cooking_community.description

    assert_text @cooking_community.posts.first.caption
  end
end
