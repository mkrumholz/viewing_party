require 'rails_helper'

RSpec.describe 'user registration form' do
  it 'creates a new user' do
    visit root_path

    click_on "Register as a User"

    expect(current_path).to eq '/register'

    username = 'test_user'
    email = 'user@test.com'
    password = 'test_password'

    fill_in :'user[username]', with: username
    fill_in :'user[email]', with: email
    fill_in :'user[password]', with: password
    fill_in :'user[password_confirmation]', with: password

    click_on 'Create User'

    expect(page).to have_content "Welcome, #{username}!"
  end

  it 'does not create a new user if password and confirmation do not match' do
    visit root_path

    click_on "Register as a User"

    expect(current_path).to eq '/register'

    username = 'test_user'
    email = 'user@test.com'
    password = 'test_password'

    fill_in :'user[username]', with: username
    fill_in :'user[email]', with: email
    fill_in :'user[password]', with: password
    fill_in :'user[password_confirmation]', with: 'something else'

    click_on 'Create User'

    expect(page).not_to have_content "Welcome, #{username}!"
  end

  it "has a link to dashboard" do
    @user = User.create!(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit root_path

    expect(page).to have_link("Dashboard")

    click_on "Dashboard"

    expect(current_path).to eq dashboard_path
  end

  it "has a link to discover movies" do
    @user = User.create!(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit root_path

    expect(page).to have_link("Discover Movies")

    click_on "Discover Movies"

    expect(current_path).to eq discover_path
  end
end
