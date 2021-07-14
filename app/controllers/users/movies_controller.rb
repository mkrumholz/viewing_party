class Users::MoviesController < Users::BaseController
  def index
    @movies = if params[:title]
                MovieDbFacade.search_results(params[:title])
              else
                MovieDbFacade.top_40_movies
              end
  end

  def show
    @movie = MovieDbFacade.movie_details(params[:id])
  end
end
