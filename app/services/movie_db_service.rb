class MovieDbService
  def self.details(movie_id)
    response = Faraday.get("https://api.themoviedb.org/3/movie/#{movie_id}") do |req|
      req.params['api_key'] = ENV['MOVIE_DB_KEY']
      req.params['language'] = 'en'
      req.params['append_to_response'] = 'credits,reviews'
    end
    Movie.new(parse_json(response))
  end

  def self.top_40
    response1 = Faraday.get('https://api.themoviedb.org/3/discover/movie') do |req|
      req.params['api_key'] = ENV['MOVIE_DB_KEY']
      req.params['sort_by'] = 'popularity.desc'
      req.params['include_adult'] = 'false'
    end
    response2 = Faraday.get('https://api.themoviedb.org/3/discover/movie') do |req|
      req.params['api_key'] = ENV['MOVIE_DB_KEY']
      req.params['sort_by'] = 'popularity.desc'
      req.params['include_adult'] = 'false'
      req.params['page'] = 2
    end
    parse_json(response1)[:results] + parse_json(response2)[:results]
  end

  def self.search_results(title)
    response1 = Faraday.get('https://api.themoviedb.org/3/search/movie') do |req|
      req.params['api_key'] = ENV['MOVIE_DB_KEY']
      req.params['language'] = 'en'
      req.params['include_adult'] = 'false'
      req.params['query'] = title
    end
    response2 = Faraday.get('https://api.themoviedb.org/3/search/movie') do |req|
      req.params['api_key'] = ENV['MOVIE_DB_KEY']
      req.params['language'] = 'en'
      req.params['include_adult'] = 'false'
      req.params['query'] = title
      req.params['page'] = 2
    end
    parse_json(response1)[:results] + parse_json(response2)[:results]
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
