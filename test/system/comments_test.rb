require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup do
    @current_user = users(:john)
    login_as @current_user

    @post = @current_user.feed_posts.first
  end

  test "Posting a comment" do
    comment_content = "Best generational recipe ever!"
    visit root_path

    click_on @post.caption
    assert_text @post.caption

    fill_in "comment[content]", with: comment_content
    click_on "Comment"

    assert_text comment_content
  end

  test "Deleting a comment" do
    visit root_path

    click_on @post.caption

    comment = @post.comments.first

    assert_text comment.content

    click_on "Delete comment", match: :first

    assert_no_text comment.content
  end

  test "Updating a comment" do
    new_comment = "This is not edible at all"
    visit root_path

    click_on @post.caption
    assert_text @post.caption

    comment = @post.comments.first

    click_on "Edit comment", match: :first

    fill_in "comment[content]", with: new_comment
    assert_text @post.caption
    click_on "Save edits"

    assert_text comment.content
    assert_text @post.caption
    assert_text new_comment
  end
end
