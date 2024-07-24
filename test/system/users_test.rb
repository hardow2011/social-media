require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test 'Showing a user' do
    damaris = users(:damaris)
    visit user_path(damaris)

    assert_text damaris.username
    assert_text "u/#{damaris.username}"

    damaris.posts.ordered.first(5).each do |post|
      assert_text post.caption
    end
  end
end
