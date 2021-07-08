require 'rails_helper'

RSpec.describe 'logging out' do
  context 'as a registered user' do
    it 'can log out' do
      user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password')

      visit login_path
      
      expect(current_path).to eq login_path

      fill_in :username, with: user.username
      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on 'Log in'

      expect(current_path).to eq root_path
      expect(page).to have_content "Welcome, #{user.username}!"

      click_on 'Log out'

      expect(current_path).to eq root_path
      expect(page).to have_link('Register as a User')
      expect(page).to have_link('I already have an account')
    end
  end
end
