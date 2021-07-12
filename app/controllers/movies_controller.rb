class MoviesController < BaseController
  def index
    if params[:results]
      @movies = params[:results]
    else
      @movies = MovieDbFacade.top_40_movies
    end
  end

  def show
    @movie = MovieDbFacade.movie_details(params[:id])
  end

  def search
    search_results = MovieDbService.search_results(params[:title])
    redirect_to movies_path(results: search_results)
  end
end
