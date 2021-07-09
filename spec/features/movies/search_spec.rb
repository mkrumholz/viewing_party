require 'rails_helper'

RSpec.describe 'search movies by title' do
  it 'can search for a movie by title' do
    user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/discover'

    fill_in :title, with: 'Neverending Story'
    click_on "Search"

    expect(page.status_code).to eq 200
    expect(current_path).to eq movies_path
    expect(page).to have_content "The NeverEnding Story"
    expect(page).to have_content "Vote Average: 7.2"
  end
end
