class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  include PaginationHelper

  def home
    @communities = Community.all
    if user_signed_in?
      pagination = Pagination.new(params[:page], current_user.feed_posts)
    else
      pagination = Pagination.new(params[:page], Post.ordered)
    end
    @posts = pagination.items
    @page = pagination.page
    @has_previous_page = pagination.has_previous_page
    @has_next_page = pagination.has_next_page
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
