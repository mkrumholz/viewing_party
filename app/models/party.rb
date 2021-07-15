class Party < ApplicationRecord
  belongs_to :user
  has_many :invitations, dependent: :destroy

  validates :movie_title, presence: true
  validates :duration, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :external_movie_id, presence: true
  validate :date_is_valid?

  def send_invitations
    host = User.find(user_id)
    friends = invitations.map { |invitation| User.find(invitation.user_id) }
    friends.each do |friend|
      InvitationMailer.invite(host, friend, self).deliver_now
    end
  end

  def date_is_valid?
    return if date.blank?
  
    error_msg = 'Error: Party must be set for a future date'
    errors.add(:date, error_msg) if date <= Date.today
  end
end
