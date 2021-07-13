require 'rails_helper'

RSpec.describe MovieDbService do
  describe '.details' do
    it 'queries movie details on MovieDB' do
      movie_id = 862
      response_body = File.read('./spec/fixtures/toy_story.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['MOVIE_DB_KEY']}&language=en&append_to_response=credits,reviews")
          .with(
            headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v1.4.1'
            })
          .to_return(status: 200, body: response_body, headers: {})

      response = MovieDbService.details(movie_id)

      expect(response).to be_a Hash
      expect(response[:title]).to eq 'Toy Story'
      expect(response[:vote_average]).to eq 7.9
      expect(response[:runtime]).to eq 81
      expect(response[:genres]).to be_an Array
      expect(response[:genres].first[:name]).to eq 'Animation'
      expect(response[:overview]).to eq "Led by Woody, Andy's toys live happily in his room until Andy's birthday brings Buzz Lightyear onto the scene. Afraid of losing his place in Andy's heart, Woody plots against Buzz. But when circumstances separate Buzz and Woody from their owner, the duo eventually learns to put aside their differences."
      expect(response[:credits][:cast]).to be_an Array
      expect(response[:reviews][:results]).to be_an Array
      expect(response[:reviews][:results].count).to eq 3
    end
  end

  describe '.list_by_popularity' do
    it 'queries a list of the top 40 movies by popularity' do
      response_body_1 = File.read('./spec/fixtures/top_40_1.json')
      stub_request(:get, "https://api.themoviedb.org/3/discover/movie?api_key=#{ENV['MOVIE_DB_KEY']}&include_adult=false&language=en&sort_by=popularity.desc&page=1")
          .with(
            headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v1.4.1'
            })
          .to_return(status: 200, body: response_body_1, headers: {})
      
      response_body_2 = File.read('./spec/fixtures/top_40_2.json')
      stub_request(:get, "https://api.themoviedb.org/3/discover/movie?api_key=#{ENV['MOVIE_DB_KEY']}&include_adult=false&language=en&sort_by=popularity.desc&page=2")
          .with(
            headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v1.4.1'
            })
          .to_return(status: 200, body: response_body_2, headers: {})

      page_1_response = MovieDbService.list_by_popularity(1)
      page_2_response = MovieDbService.list_by_popularity(2)

      expect(page_1_response).to be_a Hash
      expect(page_1_response[:results].first).to be_a Hash
      expect(page_1_response[:results].count).to eq 20
      expect(page_1_response[:results].first[:title]).to eq 'Luca'        

      expect(page_2_response).to be_a Hash
      expect(page_2_response[:results].first).to be_a Hash
      expect(page_2_response[:results].count).to eq 20
      expect(page_2_response[:results].last[:title]).to eq 'Xtreme'        
    end
  end

  describe 'list_search_results' do
    it 'queries a list of movies based on a title search' do
      response_body_1 = File.read('./spec/fixtures/search_results_1.json')
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_DB_KEY']}&include_adult=false&language=en&query=Story&page=1")
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

      page_1_response = MovieDbService.list_search_results('Story', 1)
      page_2_response = MovieDbService.list_search_results('Story', 2)

      expect(page_1_response).to be_a Hash
      expect(page_1_response[:results].first).to be_a Hash
      expect(page_1_response[:results].count).to eq 20
      expect(page_1_response[:results].first[:title]).to eq 'Toy Story'        

      expect(page_2_response).to be_a Hash
      expect(page_2_response[:results].first).to be_a Hash
      expect(page_2_response[:results].count).to eq 20
      expect(page_2_response[:results].last[:title]).to eq 'The Philadelphia Story'  
    end
  end
end
