require 'rails_helper'

RSpec.describe User do
  describe 'relationships' do
    it { should have_many(:friendships).dependent(:destroy) }
    it { should have_many(:friends).through(:friendships) }
    it { should have_many(:parties)}
    it { should have_many(:invitations)}
  end

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'instance methods' do
    describe '#add_friend' do
      before :each do
        @user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
      end

      it 'is not able to add user self as a friend' do
        expect(@user.add_friend(@user)).to eq nil
      end

      it 'is not able to add a current friend as a friend' do
        user2 = User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password')
        friendship1 = Friendship.create(user_id: @user.id, friend_id: user2.id)

        expect(@user.add_friend(user2)).to eq nil
      end

      it 'can add a new friend for the user' do
        user2 = User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password')

        @user.add_friend(user2)

        expect(@user.friends).to include user2
      end
    end
  end
end
