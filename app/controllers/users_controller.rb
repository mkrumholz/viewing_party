class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.new(user)
    if new_user.save
      session[:user_id] = new_user.id
      flash[:success] = "Welcome, #{new_user.username}!"
      redirect_to root_path
    else
      flash[:error] = 'User account not created'
      redirect_to register_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
