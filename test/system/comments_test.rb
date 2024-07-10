require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup do
    login_as users(:john)

    @post = posts(:grannys_recipe)
  end

  test "Posting a comment" do
    comment_content = "Best generational recipe ever!"
    visit root_path

    click_on @post.caption

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

    comment = @post.comments.first

    assert_text comment.content

    click_on "Edit comment", match: :first

    fill_in "comment[content]", with: new_comment
    click_on "Save edits"

    assert_no_text comment.content
    assert_text new_comment
  end
end
