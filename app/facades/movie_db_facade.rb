class MovieDbFacade 
  def self.details(movie_id)
    movie_details = MovieDbService.details(movie_id)
    Movie.new(movie_details)
  end
end
