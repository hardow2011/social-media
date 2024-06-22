require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:first)
  end

  test "Creating a new post" do
    visit posts_path
    assert_selector "h1", text: "Posts"

    click_on "New Post"
    assert_selector "h1", text: "New Post"


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

    fill_in "Caption", with: "Updated Post"
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

  test "Liking a post" do
    visit posts_path
    assert_selector "h1", text: "Posts"

    assert_button "(0) Likes"

    click_on "(0) Likes", match: :first

    assert_button "(1) Like"

    click_on "(1) Like", match: :first

    assert_button "(2) Likes"
  end
end
