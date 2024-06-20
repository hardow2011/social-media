require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:first)
  end

  test "Creating a new post" do
    visit posts_path
    assert_selector "h1", text: "Posts"

    click on "New Post"
    assert_selector "h1", "New Post"

    fill_in "Caption", with: "Capybara post"
    click_on "Create Post"

    assert_selector "h1", text: "Posts"
    assert_text "Capybara post"
  end

  test "Showing a post" do
    visit posts_path
    assert_selector "h1", text: "Posts"

    click_link @post.caption

    assert_selector "h1", text: @post.caption
  end

  test "Updating a post" do
    visit posts_path
    assert_selector "h1", text: "Posts"

    click_on "Edit", match: :first
    assert_selector "h1", text: "Edit Post"

    fill_in "Caption", with: "Updated post"
    click_on "Update Post"

    assert_selector "h1", text: "Posts"
    assert_text "Updated Post"
  end

  test "Destroying a post" do
    visit posts_path
    assert_text @post.caption

    click_on "Delete", match: :first
    assert_no_text @post.caption
  end
end
