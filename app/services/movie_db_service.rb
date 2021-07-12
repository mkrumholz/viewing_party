class MovieDbService
  def self.details(movie_id)
    response = conn.get("/3/movie/#{movie_id}", { append_to_response: 'credits,reviews' })
    parse_json(response)
  end

  def self.list_by_popularity(page)
    response = conn.get("/3/discover/movie", { sort_by: 'popularity.desc', include_adult: false, page: page })
    parse_json(response)
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

  def self.conn
    Faraday.new('https://api.themoviedb.org') do |req|
      req.params['api_key'] = ENV['MOVIE_DB_KEY']
      req.params['language'] = 'en'
    end
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
