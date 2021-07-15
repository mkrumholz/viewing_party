class Party < ApplicationRecord
  belongs_to :user
  has_many :invitations, dependent: :destroy

  validates :movie_title, presence: true
  validates :duration, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :external_movie_id, presence: true

  def send_invitations
    host = User.find(user_id)
    friend = User.find(invitations.first.user_id)
    InvitationMailer.invite(host, friend, self).deliver_now
  end
end
