module ApplicationHelper
  include Rails.application.routes.url_helpers

  alias new_post_path new_community_post_path

  # The reason for using route methods is to keep the nested format in the post routes
  def post_path(post)
    community_post_path(post.community, post)
  end

  def edit_post_path(post)
    edit_community_post_path(post.community, post)
  end

  def to_b(value)
    ['true', true, 1, '1'].include?(value)
  end
end
