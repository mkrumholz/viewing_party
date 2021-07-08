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
end
