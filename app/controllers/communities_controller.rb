class CommunitiesController < ApplicationController
  include CommunitySetting

  before_action only: %i[show] do
    set_community_by_handle(params[:id])
  end

  def new
    @community = Community.new
  end

  def create
    @community = Community.new(community_params)

    if @community.save
      redirect_to community_path(@community), notice: "Community was created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show

  end

  private

  def set_community
    @community =  Community.find(params[:id])
  end

  def community_params
    params.require(:community).permit(:name, :description)
  end
end
