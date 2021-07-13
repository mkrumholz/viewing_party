require 'rails_helper'

RSpec.describe Invitation do
  describe 'relationships' do
    it {should belong_to :party}
    it {should belong_to :user}
  end

  describe 'instance methods' do
    describe '#guest_name' do
      it "returns users username" do
        @user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
        @user2 = User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password')
        @friendship1 = Friendship.create(user_id: @user.id, friend_id: @user2.id)
        @party = @user.parties.create(movie_title: "Toy Story", duration: "81", date: "2021-07-14", start_time: "2021-07-12 01:00:00 -0600", external_movie_id: 862)
        @invitation = @party.invitations.create(user_id: @user2.id)
        expect(@invitation.guest_name).to eq(@user2.username)
      end
    end
  end
end
