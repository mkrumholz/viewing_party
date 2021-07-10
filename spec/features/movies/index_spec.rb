require 'rails_helper'

RSpec.describe 'Movies index' do
  describe 'search' do
    before :each do
      user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/discover'

      response_body_1 = File.read('./spec/fixtures/search_results_1.json')
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_DB_KEY']}&include_adult=false&language=en&query=Story")
          .with(
            headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v1.4.1'
            })
          .to_return(status: 200, body: response_body_1, headers: {})

      response_body_2 = File.read('./spec/fixtures/search_results_2.json')
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_DB_KEY']}&include_adult=false&language=en&query=Story&page=2")
          .with(
            headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v1.4.1'
            })
          .to_return(status: 200, body: response_body_2, headers: {})

      fill_in :title, with: 'Story'
      click_on "Search"
    end

    it 'can search for a movie by title' do
      expect(page.status_code).to eq 200
      expect(current_path).to eq movies_path
      expect(page).to have_content "Toy Story"
      expect(page).to have_content "Vote Average: 7.9"
    end

    it 'only displays first 40 search results' do
      expect(page).to have_content "Toy Story" # 1st result
      expect(page).to have_content "The Philadelphia Story" # 40th result
      expect(page).not_to have_content "The Pixar Story" # 41st result
    end

    it 'links to each movie show page' do
      click_on 'Toy Story'

      expect(current_path).to eq movie_path(862)
    end
  end

  describe 'top 40 movies' do
    before :each do
      user = User.create(username: 'test_user', email: 'user@test.com', password: 'test_password', password_confirmation: 'test_password')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      response_body_1 = File.read('./spec/fixtures/top_40_1.json')
      stub_request(:get, "https://api.themoviedb.org/3/discover/movie?api_key=#{ENV['MOVIE_DB_KEY']}&include_adult=false&sort_by=popularity.desc")
          .with(
            headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v1.4.1'
            })
          .to_return(status: 200, body: response_body_1, headers: {})
      
      response_body_2 = File.read('./spec/fixtures/top_40_2.json')
      stub_request(:get, "https://api.themoviedb.org/3/discover/movie?api_key=#{ENV['MOVIE_DB_KEY']}&include_adult=false&sort_by=popularity.desc&page=2")
          .with(
            headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v1.4.1'
            })
          .to_return(status: 200, body: response_body_2, headers: {})
    end

    it 'can display the top 40 movies' do
      visit '/discover'
      click_on 'Discover Top 40 Movies'
      
      expect(current_path).to eq movies_path
      expect(page).to have_content "The Boss Baby: Family Business"
      expect(page).to have_content "Vote Average: 8"
      expect(page).to have_content "Xtreme"
      expect(page).to have_content "Vote Average: 7"
    end

    it "has a link to discover top 40 movies" do
      visit '/movies'

      expect(page).to have_button('Discover Top 40 Movies')

      click_on 'Discover Top 40 Movies'

      expect(current_path).to eq('/movies')
    end

    it 'links to each movie show page' do
      click_on 'The Boss Baby: Family Business'

      expect(current_path).to eq movie_path(459151)
    end
  end
end
