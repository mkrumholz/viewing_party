class Users::DiscoverController < Users::BaseController
  def show
    @user = User.find(current_user.id)
  end
end
