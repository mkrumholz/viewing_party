require 'rails_helper'

RSpec.describe 'user registration form' do
  it 'creates a new user' do
    visit root_path

    click_on "Register as a User"

    expect(current_path).to eq '/register'

    username = 'test_user'
    password = 'test_password'

    fill_in :username, with: username
    fill_in :password, with: password    

    click_on 'Create User'

    expect(page).to have_content "Welcome, #{username}!"
  end
end
