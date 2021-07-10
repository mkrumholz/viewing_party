require 'rails_helper'

RSpec.describe 'movie show page' do
  before :each do
    user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    response_body = File.read('./spec/fixtures/toy_story.json')
    stub_request(:get, "https://api.themoviedb.org/3/movie/862?api_key=#{ENV['MOVIE_DB_KEY']}&language=en")
        .with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.4.1'
          })
        .to_return(status: 200, body: response_body, headers: {})

    visit '/movies/862'
  end

  it 'displays the movie title' do
    expect(page).to have_content 'Toy Story'
  end

  it 'displays the vote average, runtime, and genre(s)'

  it 'displays a summary'

  it 'displays the first 10 cast members'

  it 'displays a count of reviews'

  it 'lists all reviews along with their authors'

  it 'has a link to create a viewing party' 
end
