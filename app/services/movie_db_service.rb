class MovieDbService
  def self.details(movie_id)
    response = conn.get("/3/movie/#{movie_id}", { append_to_response: 'credits,reviews' })
    parse_json(response)
  end

  def self.list_by_popularity(page)
    response = conn.get('/3/movie/top_rated', { include_adult: false, page: page })
    parse_json(response)
  end

  def self.list_search_results(title, page)
    response = conn.get('/3/search/movie', { include_adult: false, query: title, page: page })
    parse_json(response)
  end

  def self.conn
    Faraday.new('https://api.themoviedb.org') do |req|
      req.params['api_key'] = ENV['MOVIE_DB_KEY']
      req.params['language'] = 'en'
    end
  end

  def self.parse_json(response)
    return { results: [] } if response.body.empty?

    JSON.parse(response.body, symbolize_names: true)
  end
end
