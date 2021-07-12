class Movie
  attr_reader :title, :vote_average, :runtime, :genres, :summary

  def initialize(movie_details)
    @title = movie_details[:title]
    @vote_average = movie_details[:vote_average]
    @runtime = movie_details[:runtime]
    @genres = movie_details[:genres]
    @summary = movie_details[:overview]
    @credits = movie_details[:credits]
    @reviews = movie_details[:reviews]
  end

  def cast_members
    @credits[:cast].first(10)
  end

  def reviews
    @reviews[:results]
  end
end
