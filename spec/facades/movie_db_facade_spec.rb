require 'rails_helper'

RSpec.describe MovieDbFacade do
  describe '.movie_details' do
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

      response = MovieDbFacade.movie_details(movie_id)

      expect(response).to be_a Movie
      expect(response.title).to eq 'Toy Story'
    end
  end

  describe '.top_40_movies' do
    it 'queries a list of the top 40 movies by popularity' do
      response_body_1 = File.read('./spec/fixtures/top_40_1.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_DB_KEY']}&include_adult=false&language=en&page=1")
          .with(
            headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v1.4.1'
            })
          .to_return(status: 200, body: response_body_1, headers: {})
      
      response_body_2 = File.read('./spec/fixtures/top_40_2.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_DB_KEY']}&include_adult=false&language=en&page=2")
          .with(
            headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v1.4.1'
            })
          .to_return(status: 200, body: response_body_2, headers: {})

      expect(MovieDbFacade.top_40_movies).to be_a Array
      expect(MovieDbFacade.top_40_movies.length).to eq 40
      expect(MovieDbFacade.top_40_movies.first).to be_a Movie
      expect(MovieDbFacade.top_40_movies.first.title).to eq 'Dilwale Dulhania Le Jayenge'        
      expect(MovieDbFacade.top_40_movies.last.title).to eq 'A Silent Voice: The Movie'        
    end
  end

  describe 'search_results' do
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

      response = MovieDbFacade.search_results('Story')

      expect(response).to be_a Array
      expect(response.length).to be <= 40
      expect(response.first).to be_a Movie       
      expect(response.last.title).to eq 'The Philadelphia Story'
    end
  end
end
