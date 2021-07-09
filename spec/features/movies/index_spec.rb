require 'rails_helper'

RSpec.describe 'Movies index' do
  it 'can search for a movie by title' do
    user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/discover'

    response_body_1 = File.read('./spec/fixtures/search_results_1.json')
    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=5aa90bee5771d3777a52a10d8dbc83ca&include_adult=false&language=en&query=Story")
         .with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.4.1'
           })
         .to_return(status: 200, body: response_body_1, headers: {})

    response_body_2 = File.read('./spec/fixtures/search_results_2.json')
    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=5aa90bee5771d3777a52a10d8dbc83ca&include_adult=false&language=en&query=Story&page=2")
        .with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.4.1'
          })
        .to_return(status: 200, body: response_body_2, headers: {})

    fill_in :title, with: 'Story'
    click_on "Search"

    expect(page.status_code).to eq 200
    expect(current_path).to eq movies_path
    expect(page).to have_content "Toy Story"
    expect(page).to have_content "Vote Average: 7.9"
  end

  it 'only displays first 40 search results' do
    user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/discover'

    response_body_1 = File.read('./spec/fixtures/search_results_1.json')
    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=5aa90bee5771d3777a52a10d8dbc83ca&include_adult=false&language=en&query=Story")
         .with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.4.1'
           })
         .to_return(status: 200, body: response_body_1, headers: {})

    response_body_2 = File.read('./spec/fixtures/search_results_2.json')
    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=5aa90bee5771d3777a52a10d8dbc83ca&include_adult=false&language=en&query=Story&page=2")
        .with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.4.1'
          })
        .to_return(status: 200, body: response_body_2, headers: {})
    
    fill_in :title, with: 'Story'
    click_on "Search"

    expect(page).to have_content "Toy Story"
    expect(page).to have_content "The Philadelphia Story"
    expect(page).not_to have_content "The Pixar Story"
  end

  it 'can display the top 40 movies'
end
