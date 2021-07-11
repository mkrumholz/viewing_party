require 'rails_helper'
RSpec.describe 'New Viewing Party' do
  before :each do
    @user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    @user2 = User.create(username: 'test_user2', email: 'user2@test.com', password: 'test_password', password_confirmation: 'test_password')
    @user3 = User.create(username: 'test_user3', email: 'user3@test.com', password: 'test_password', password_confirmation: 'test_password')
    @user4 = User.create(username: 'test_user4', email: 'user4@test.com', password: 'test_password', password_confirmation: 'test_password')
    @friendship1 = Friendship.create(user_id: @user.id, friend_id: @user2.id)
    @friendship2 = Friendship.create(user_id: @user.id, friend_id: @user3.id)
    @friendship3 = Friendship.create(user_id: @user.id, friend_id: @user4.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    response_body = File.read('./spec/fixtures/toy_story.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/862?api_key=#{ENV['MOVIE_DB_KEY']}&language=en&append_to_response=credits,reviews")
        .with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.4.1'
          })
        .to_return(status: 200, body: response_body, headers: {})

    visit '/movies/862'
  end

  it "Creates a new viewing party" do
    expect(page).to have_content 'Toy Story'
    click_on 'Create Viewing Party for Movie'

    expect(current_path).to eq new_viewing_party_path

    duration = '81'
    day = '7/14/21'
    start_time = '1:00'
    save_and_open_page

    expect(page).to have_content(@user2.username)
    expect(page).to have_content(@user3.username)
    expect(page).to have_content(@user4.username)
    check(@user2.username)
    check(@user3.username)
    check(@user4.username)
    uncheck(@user3.username)
    click_on "Create Party"
  end
end
