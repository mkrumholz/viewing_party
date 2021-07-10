class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, presence: { require: true }

  has_secure_password

  def add_friend(friend)
    friends << friend unless friend == self || friends.include?(friend)
  end
end
