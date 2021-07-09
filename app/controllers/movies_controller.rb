class MoviesController < ApplicationController
  def index
    @search_results = params[:results]
  end

  def search
    response = Faraday.get('https://api.themoviedb.org/3/search/movie') do |req|
      req.params['api_key'] = ENV['MOVIE_DB_KEY']
      req.params['language'] = 'en'
      req.params['include_adult'] = 'false'
      req.params['query'] = params[:title]
    end
    json = JSON.parse(response.body, symbolize_names: true)
    @search_results = json[:results]
    redirect_to movies_path(results: @search_results)
  end
end
