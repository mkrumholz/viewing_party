class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :party

  def guest_name
    User.find(user_id).username
  end
end
