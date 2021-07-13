class Party < ApplicationRecord
  belongs_to :user

  validates :movie_title, presence: true
  validates :duration, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
end
