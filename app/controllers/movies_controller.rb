class MoviesController < BaseController
  def index
    if params[:title]
      @movies = MovieDbFacade.search_results(params[:title])
    else
      @movies = MovieDbFacade.top_40_movies
    end
  end

  def show
    @movie = MovieDbFacade.movie_details(params[:id])
  end
end
