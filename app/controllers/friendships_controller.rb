class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(email: params[:email])
    if friend.present?
      friendship = Friendship.new(user_id: current_user.id, friend_id: friend.id)
      if friendship.save
        flash[:sucess] = 'Friend successfully added!'
      else
        flash[:error] = 'Friendship not successfully created.'
      end
    else
      flash[:error] = "Unable to add friend. User with email #{params[:email]} not found."
    end
    redirect_to dashboard_path
  end
end
