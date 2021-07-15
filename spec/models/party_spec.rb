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

  describe 'send_invitations' do
    it 'sends an email to invited guests when created' do
      @user = User.create!(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @user2 = User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password')
      # @user3 = User.create(username: 'test_user3', email: 'user3@test.com', password: 'test_password', password_confirmation: 'test_password')
      # @user4 = User.create(username: 'test_user4', email: 'user4@test.com', password: 'test_password', password_confirmation: 'test_password')
      @friendship1 = Friendship.create(user_id: @user.id, friend_id: @user2.id)
      # @friendship2 = Friendship.create(user_id: @user.id, friend_id: @user3.id)
      # @friendship3 = Friendship.create(user_id: @user.id, friend_id: @user4.id)
      @party = @user.parties.create(movie_title: "Toy Story", duration: "81", date: "2021-07-14", start_time: "2021-07-12 13:00:00 -0600", external_movie_id: 862)
      @party.invitations.create(user_id: @user2.id)
      # @party.invitations.create(user_id: @user3.id)

      expect { @party.send_invitations }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
