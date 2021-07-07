class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, presence: { require: true }

  has_secure_password
end
