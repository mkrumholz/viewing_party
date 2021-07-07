class SessionsController < ApplicationController
  def new; end

  def create
    found_user = User.find_by(email: params[:email])
    if found_user && found_user.authenticate(params[:password])
      session[:user_id] = found_user.id
      flash[:success] = "Welcome, #{found_user.username}!"
      redirect_to root_path
    else
      flash[:error] = 'User account not found or credentials are incorrect'
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
