class Users::BaseController < ApplicationController
  before_action :authorize_user

  private

  def authorize_user
    return if current_user

    redirect_to root_path
    flash[:error] = 'Error: Please log in to view this content.'
  end
end
