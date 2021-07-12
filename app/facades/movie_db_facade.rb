class MovieDbFacade 
  def self.movie_details(movie_id)
    movie_details = MovieDbService.details(movie_id)
    Movie.new(movie_details)
  end

  def self.top_40_movies
    page1 = MovieDbService.list_by_popularity(1)
    page2 = MovieDbService.list_by_popularity(2)
    movie_list = page1[:results] + page2[:results]
    movie_list.map do |movie_details|
      Movie.new(movie_details)
    end
  end
end
