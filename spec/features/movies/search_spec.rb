require 'rails_helper'

RSpec.describe 'search movies by title' do
  it 'can search for a movie by title' do
    user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/discover'

    response_body = File.read('./spec/fixtures/search_results.json')
    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=5aa90bee5771d3777a52a10d8dbc83ca&include_adult=false&language=en&query=Neverending%20Story").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.4.1'
           }).
         to_return(status: 200, body: response_body, headers: {})

    fill_in :title, with: 'Neverending Story'
    click_on "Search"

    expect(page.status_code).to eq 200
    expect(current_path).to eq movies_path
    expect(page).to have_content "The NeverEnding Story"
    expect(page).to have_content "Vote Average: 7.2"
  end
end
