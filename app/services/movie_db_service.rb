class MovieDbService
  def self.details(movie_id)
    response = Faraday.get("https://api.themoviedb.org/3/movie/#{movie_id}") do |req|
      req.params['api_key'] = ENV['MOVIE_DB_KEY']
      req.params['language'] = 'en'
    end
    movie_details = JSON.parse(response.body, symbolize_names: true)
    Movie.new(movie_details)
  end
end
