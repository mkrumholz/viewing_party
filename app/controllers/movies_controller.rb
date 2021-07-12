class MoviesController < AuthorizationController
  def index
    if params[:results]
      @movies = params[:results]
    else
      @movies = MovieDbService.top_40
    end
  end

  def show
    @movie = MovieDbService.details(params[:id])
  end

  def search
    search_results = MovieDbService.search_results(params[:title])
    redirect_to movies_path(results: search_results)
  end
end
