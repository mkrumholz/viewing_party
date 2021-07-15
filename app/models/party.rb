class Party < ApplicationRecord
  belongs_to :user
  has_many :invitations, dependent: :destroy

  validates :movie_title, presence: true
  validates :duration, presence: true
  validates :date, presence: true
  validates :external_movie_id, presence: true
  validate :date_is_valid?

  def send_invitations
    friends = invitations.map { |invitation| User.find(invitation.user_id) }
    friends.each do |friend|
      InvitationMailer.invite(host, friend, self).deliver_now
    end
  end

  def date_is_valid?
    return if date.blank?
  
    error_msg = 'Error: Party must be set for a future date'
    errors.add(:date, error_msg) if date < Time.now
  end

  def starts_at_date=(date)
    @starts_at_date = date
    set_date
    date
  end

  def starts_at_time=(time)
    @starts_at_time = time
    set_date
    time
  end

  def starts_at_date
    date&.strftime('%m/%d/%Y')
  end

  def starts_at_time
    date&.strftime('%H:%M')
  end

  def set_date
    if @starts_at_date && @starts_at_time
      self.date = Time.zone.parse("#{@starts_at_date} #{@starts_at_time}")
    end
  end
  
  def host
    User.find(user_id)
  end
  
  def host
    User.find(user_id)
  end
end
