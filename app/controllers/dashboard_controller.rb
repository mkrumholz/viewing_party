class DashboardController < ApplicationController
  def show
    if current_user && User.find(current_user.id)
      @user = User.find(current_user.id)
    else
      redirect_to root_path
    end
  end
end
