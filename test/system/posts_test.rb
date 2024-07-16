require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  include CommunityHelper
  setup do
    @current_user = users(:john)
    login_as @current_user

    @post = @current_user.feed_posts.first
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

    click_on handle_path(@post.community)

    assert_text @post.community.handle
    assert_text @post.community.description
  end

  test "Updating a post" do
    visit root_path
    click_on @cooking_community.handle

    assert_text @cooking_community.handle
    assert_text @cooking_community.description

    click_on "Edit", match: :first
    assert_selector "h1", text: "Edit Post"

    fill_in "Caption", with: "Updated Post"
    click_on "Update Post"

    assert_text @cooking_community.handle
    assert_text @cooking_community.description

    assert_text "Updated Post"
  end

  test "Destroying a post" do
    visit root_path

    my_post = @current_user.posts.first

    assert_text my_post.caption

    click_on "Delete", match: :first
    assert_no_text my_post.caption
  end

  test "Liking a post" do
    visit root_path

    assert_button "(0) Likes"

    click_on "(0) Likes", match: :first

    assert_button "(1) Like"

    click_on "(1) Like", match: :first

    assert_button "(0) Likes"
  end

  test "Showing posts on home page" do
    visit root_path

    non_feed_posts = posts - @current_user.feed_posts

    # Only show posts from subbed communities on home page when logged in

    @current_user.feed_posts.each do |p|
      assert_text p.caption
    end

    non_feed_posts.each do |p|
      assert_no_text p.caption
    end

    click_on "Sign out"

    # Show all posts all communities on home page when not logged in

    posts.each do |p|
      assert_text p.caption
    end
  end
end
