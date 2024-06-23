require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @cooking_community = communities(:cooking)
  end

  test "Creating a new Community" do
    visit posts_path
    assert_selector :h1, text: "Posts"

    click_on "New Community"
    assert_selector :h1, text: 'New Community'

    fill_in "Name", "Casual Woodworking"
    fill_in "Description", "For wood workers and beyond"

    click_on "Create Community"

    assert_text "Casual Woodworking"
    assert_text "casual_woodworking"
    assert_text "For wood workers and beyond"
  end

  test "Showing a Community" do
    visit posts_path
    assert_selector :h1, text: "Posts"

    click_on @cooking_community.handle

    assert_selector :h1, text: @cooking_community.handle

    assert_text @cooking_community.post.first.caption
  end
end
