class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :authenticate_user!, unless: :devise_controller?

  # TODO: create way to prevent redirects to certain pages

  private

  def after_sign_in_path_for(resource)
    if params[:redirect_to].present?
      store_location_for(resource, params[:redirect_to])
    elsif request.original_url == new_session_url(:user)
      super
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end
end
