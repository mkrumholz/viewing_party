class Movie
  attr_reader :title, :id, :vote_average, :runtime, :genres, :summary, :reviews

  def initialize(movie_details)
    @title = movie_details[:title]
    @id = movie_details[:id]
    @vote_average = movie_details[:vote_average]
    @runtime = movie_details[:runtime]
    @genres = movie_details[:genres]
    @summary = movie_details[:overview]
    @cast = movie_details[:credits][:cast]
    @reviews = movie_details[:reviews][:results]
  end

  def cast_members
    @cast.first(10)
  end
end
