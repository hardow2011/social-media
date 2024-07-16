class CommunitiesController < ApplicationController
  include CommunitySetting
  include PaginationHelper

  skip_before_action :authenticate_user!, only: %[show]

  before_action only: %i[show join_community] do
    set_community_by_handle(params[:id])
  end

  def new
    @community = Community.new
  end

  def create
    @community = Community.new(community_params)
    @community.creator = current_user

    if @community.save
      redirect_to community_path(@community), notice: "Community was created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    page = params[:page].to_i
    # If page param lower than 1, then make @page = 1...
    # otherwise keep @page = param[:page]
    @page = page < 1 ? 1 : page

    @last_page = (@community.posts.size.to_f / posts_per_page).ceil
    @last_page = @last_page == 0 ? 1 : @last_page

    if @page > @last_page
      @page = @last_page
      @posts = @community.posts.page(@last_page, posts_per_page)
    else
      @posts = @community.posts.page(@page, posts_per_page)
    end

    @is_next_page = !@community.posts.page(@page+1, posts_per_page).empty?
    @is_previous_page = @page - 1 <= 0 ? false : true
  end

  def join_community
    unless current_user.belongs_to_community?(@community)
      current_user.communities << @community
    else
      current_user.communities.delete(@community)
    end
    redirect_to community_path(@community)
  end

  private

  def community_params
    params.require(:community).permit(:handle, :description)
  end
end
