module ApplicationHelper
  include Rails.application.routes.url_helpers

  def post_path(post)
    community_post_path(post.community, post)
  end
end
