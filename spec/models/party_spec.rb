require 'rails_helper'

RSpec.describe Party do
  describe 'relationships' do
    it {should belong_to :user}
    it {should have_many(:invitations).dependent(:destroy)}
  end

  describe 'validations' do
    it { should validate_presence_of(:movie_title) }
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:external_movie_id) }
  end
end
