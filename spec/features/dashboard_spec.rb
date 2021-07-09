require 'rails_helper'

RSpec.describe 'User dashboard' do
  it "displays a welcome message if user is logged in" do
    # As an authenticated user,
    # When I visit '/dashboard'
    # I should see:
    #
    # 'Welcome <username>!' at the top of page
    # Movies Page #9 A button to Discover Movies
    # Dashboard: Viewing Parties #10 A friends section
    # Dashboard: Friends #11 A viewing parties section
    user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/dashboard'
    expect(page).to have_content("Welcome, #{user.username}!")
  end

  it "does not display welcome message if user is not logged in" do
    user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    visit '/dashboard'
    expect(page).not_to have_content("Welcome, #{user.username}!")
    expect(current_path).to eq root_path
  end

  it "has a link to discover movies" do
    user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/dashboard'
    expect(page).to have_link("Discover Movies")
    click_on "Discover Movies"
    expect(current_path).to eq("/discover")
  end

  it "can add a friend" do
    user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    user2 = User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password')
    user3 = User.create(username: 'test_user3', email: 'user3@test.com', password: 'test_password', password_confirmation: 'test_password')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/dashboard'
    expect(page).not_to have_content(user2.username)
    fill_in :email, with: user2.email
    click_on "Add Friend"
    expect(page).to have_content(user2.username)
    expect(page).not_to have_content(user3.username)
  end

  it "displays an error message if friend is not found" do
    user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/dashboard'
    fill_in :email, with: 'user2@gmail.com'
    click_on "Add Friend"
    expect(page).to have_content("Unable to add friend. User with email user2@gmail.com not found.")
  end

  it "shows a message if user has no friends" do
    user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/dashboard'
    expect(page).to have_content "You currently have no friends"
  end

  it "displays a list of users friends" do
    user1 = User.create(username: 'test_user1', email: 'user1@test.com', password: 'test_password', password_confirmation: 'test_password')
    user2 = User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password')
    user3 = User.create(username: 'test_user3', email: 'user3@test.com', password: 'test_password', password_confirmation: 'test_password')
    user4 = User.create(username: 'test_user4', email: 'user4@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
    friendship1 = Friendship.create(user_id: user1.id, friend_id: user2.id)
    friendship2 = Friendship.create(user_id: user1.id, friend_id: user3.id)
    visit '/dashboard'
    expect(page).to have_content(user2.username)
    expect(page).to have_content(user3.username)
    expect(page).not_to have_content(user4.username)
  end
end
