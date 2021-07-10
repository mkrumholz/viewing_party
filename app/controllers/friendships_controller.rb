class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(email: params[:email])
    if friend.present?
      validate_friendship(friend)
    else
      flash[:error] = "Unable to add friend. User with email #{params[:email]} not found."
    end
    redirect_to dashboard_path
  end

  private

  def validate_friendship(friend)
    if current_user.add_friend(friend)
      flash[:sucess] = 'Friend successfully added!'
    elsif friend.id == current_user.id
      flash[:error] = "Error: This is just sad. You can\'t add yourself as a friend."
    elsif current_user.friends.include?(friend)
      flash[:error] = 'Error: You are already friends with this user.'
    else
      flash[:error] = 'Friendship not successfully created.'
    end
  end
end
