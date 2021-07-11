require 'rails_helper'

RSpec.describe MovieDbService do
  describe 'details' do
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

      expect(response).to be_a Movie
      expect(response.title).to eq 'Toy Story'
    end
  end
end
