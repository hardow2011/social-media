class UsersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_user_by_username, only: %i[show]

  def show
  end

  private

  def set_user_by_username
    @user = User.get_by_username(params[:id])
  end
end
