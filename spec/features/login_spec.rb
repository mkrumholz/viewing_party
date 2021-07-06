require 'rails_helper'

RSpec.describe 'log in' do
  it 'can log in with valid credentials' do
    user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password')

    visit root_path

    click_on 'I already have an account'

    expect(current_path).to eq login_path

    fill_in :username, with: user.username
    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'Log in'

    expect(current_path).to eq root_path
    expect(page).to have_content "Welcome, #{user.username}!"
  end

  it 'cannot log in with bad credentials' do
    user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password')

    visit login_path
    
    fill_in :username, with: user.username
    fill_in :email, with: user.email
    fill_in :password, with: 'incorrect password'

    click_on 'Log in'

    expect(current_path).to eq login_path
    expect(page).to have_content 'User account not found or credentials are incorrect'
  end
end
