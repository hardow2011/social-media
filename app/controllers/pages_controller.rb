class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @communities = Community.all
    if user_signed_in?
      @posts = current_user.feed_posts
    else
      @posts = Post.ordered
    end
  end
end
