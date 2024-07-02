module CommunityHelper
  def handle_path(community)
    community_path(community).delete_prefix('/')
  end
end
