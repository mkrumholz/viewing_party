class BaseController < ApplicationController
  before_action :authorize_user

  private 

  def authorize_user
    redirect_to root_path unless current_user
    flash[:error] = "Error: Please log in to view this content."
  end
end
