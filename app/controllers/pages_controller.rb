class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @communities = Community.all
    @posts = Post.ordered
  end
end
