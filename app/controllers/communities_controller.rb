class CommunitiesController < ApplicationController
  include CommunitySetting
  include PaginationHelper

  skip_before_action :authenticate_user!, only: %i[show]

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
    pagination = Pagination.new(params[:page], @community.posts)
    @posts = pagination.items
    @page = pagination.page
    @has_previous_page = pagination.has_previous_page
    @has_next_page = pagination.has_next_page

    respond_to do |format|
      format.html
      format.turbo_stream
    end
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
