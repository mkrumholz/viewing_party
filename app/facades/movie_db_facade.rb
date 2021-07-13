class MovieDbFacade
  def self.movie_details(movie_id)
    movie_details = MovieDbService.details(movie_id)
    Movie.new(movie_details)
  end

  def self.top_40_movies
    top_rated_movies(2)
  end

  def self.top_rated_movies(pages)
    results = []
    pages.times do |page|
      json = MovieDbService.list_by_popularity(page + 1)
      results += json_to_movies(json)
    end
    results
  end

  def self.search_results(title)
    page1 = MovieDbService.list_search_results(title, 1)
    page2 = MovieDbService.list_search_results(title, 2)
    json_to_movies(page1) + json_to_movies(page2)
  end

  def self.json_to_movies(json)
    json[:results].map { |movie_details| Movie.new(movie_details) }
  end
end
