class Party < ApplicationRecord
  belongs_to :user
  has_many :invitations, dependent: :destroy

  validates :movie_title, presence: true
  validates :duration, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :external_movie_id, presence: true

  def send_invitations
    friends = invitations.map { |invitation| User.find(invitation.user_id) }
    friends.each do |friend|
      InvitationMailer.invite(host, friend, self).deliver_now
    end
  end

  def host
    User.find(user_id)
  end
end
