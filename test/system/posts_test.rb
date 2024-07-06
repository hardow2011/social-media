require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    login_as users(:john)
    @post = posts(:grannys_recipe)
    @cooking_community = communities(:cooking)
    @cars_community = communities(:cars)
  end

  test "Creating a new post" do
    visit community_path(@cooking_community)

    click_on "New Post"
    assert_selector "h1", text: "New Post"


    fill_in "Caption", with: "Capybara post"
    click_on "Create Post"

    assert_text @cooking_community.handle
    assert_text @cooking_community.name
    assert_text @cooking_community.description

    assert_text "Capybara post"

    assert_text @cooking_community.posts.first.caption
    assert_no_text @cars_community.posts.first.caption
  end

  test "Showing a post" do
    visit root_path

    click_link @post.caption

    assert_text @post.caption

    @post.comments.first(3).each do |comment|
      assert_text comment.content
    end
  end

  test "Updating a post" do
    visit root_path
    click_on @cooking_community.handle

    assert_text @cooking_community.handle
    assert_text @cooking_community.name
    assert_text @cooking_community.description

    click_on "Edit", match: :first
    assert_selector "h1", text: "Edit Post"

    fill_in "Caption", with: "Updated Post"
    click_on "Update Post"

    assert_text @cooking_community.handle
    assert_text @cooking_community.name
    assert_text @cooking_community.description

    assert_text "Updated Post"
  end

  test "Destroying a post" do
    visit root_path
    click_on @cooking_community.handle

    assert_text @post.caption

    click_on "Delete", match: :first
    assert_no_text @post.caption
  end

  test "Liking a post" do
    visit root_path

    assert_button "(0) Likes"

    click_on "(0) Likes", match: :first

    assert_button "(1) Like"

    click_on "(1) Like", match: :first

    assert_button "(0) Likes"
  end

  test "showing all posts on home page" do
    visit root_path

    assert_text @cooking_community.posts.first.caption
    assert_text @cars_community.posts.first.caption
  end
end
