require 'rails_helper'

RSpec.describe 'User dashboard' do
  context 'when user is logged in' do
    before :each do
      @user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "displays a welcome message if user is logged in" do
      visit '/dashboard'

      expect(page).to have_content("Welcome, #{@user.username}!")
    end

    it "has a link to discover movies" do
      visit '/dashboard'

      expect(page).to have_link("Discover Movies")

      click_on "Discover Movies"

      expect(current_path).to eq("/discover")
    end

    it "shows a message if user has no friends" do
      visit '/dashboard'

      expect(page).to have_content "You currently have no friends"
    end
  
    it "can add a friend" do
      user2 = User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password')
      user3 = User.create(username: 'test_user3', email: 'user3@test.com', password: 'test_password', password_confirmation: 'test_password')

      visit '/dashboard'

      expect(page).not_to have_content(user2.username)

      fill_in :email, with: user2.email
      click_on "Add Friend"

      expect(page).to have_content(user2.username)
      expect(page).not_to have_content(user3.username)
    end

    it "displays a list of users friends" do
      user2 = User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password')
      user3 = User.create(username: 'test_user3', email: 'user3@test.com', password: 'test_password', password_confirmation: 'test_password')
      user4 = User.create(username: 'test_user4', email: 'user4@test.com', password: 'test_password', password_confirmation: 'test_password')
      friendship1 = Friendship.create(user_id: @user.id, friend_id: user2.id)
      friendship2 = Friendship.create(user_id: @user.id, friend_id: user3.id)

      visit '/dashboard'

      expect(page).to have_content(user2.username)
      expect(page).to have_content(user3.username)
      expect(page).not_to have_content(user4.username)
    end
  
    it "displays an error message if friend is not found" do
      visit '/dashboard'

      fill_in :email, with: 'user2@gmail.com'
      click_on "Add Friend"

      expect(page).to have_content("Unable to add friend. User with email user2@gmail.com not found.")
    end
  
    it 'does not allow user to add themself as a friend' do
      visit '/dashboard'

      fill_in :email, with: 'user@test.com'
      click_on "Add Friend"

      expect(page).to have_content("Error: This is just sad. You can\'t add yourself as a friend.")
    end

    it 'does not allow user to add friends who are already friends' do
      user2 = User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password')
      friendship1 = Friendship.create(user_id: @user.id, friend_id: user2.id)

      visit '/dashboard'

      expect(page).to have_content(user2.username)

      fill_in :email, with: 'user2@test.com'
      click_on "Add Friend"

      expect(page).to have_content("Error: You are already friends with this user.")
    end

    it 'throws a generic error if friend is not saved' do
      user2 = User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password')
      allow_any_instance_of(User).to receive(:add_friend).and_return(false)

      visit '/dashboard'

      fill_in :email, with: 'user2@test.com'
      click_on "Add Friend"

      expect(page).to have_content("Friendship not successfully created.")
    end
  end

  context 'when user is NOT logged in' do
    it "redirects to the home screen and throws an error if user is not logged in" do
      user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')

      visit '/dashboard'

      expect(page).not_to have_content("Welcome, #{user.username}!")
      expect(page).to have_content("Error: Please log in to view this content.")
      expect(current_path).to eq root_path
    end
  end
end
