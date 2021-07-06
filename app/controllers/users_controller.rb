class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.create(user)
    flash[:success] = "Welcome, #{new_user.username}!"
    redirect_to root_path
  end

  def login_form
  end

  def login
    found_user = User.find_by(email: params[:email])
    flash[:success] = "Welcome, #{found_user.username}!"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
