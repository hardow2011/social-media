class CommunitiesController < ApplicationController
  before_action :set_community, only: %i[show]

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
