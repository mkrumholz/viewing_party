class MoviesController < ApplicationController
  def index
    if params[:results]
      @movies = params[:results]
    else 
      response_1 = Faraday.get('https://api.themoviedb.org/3/discover/movie') do |req|
        req.params['api_key'] = ENV['MOVIE_DB_KEY']
        req.params['sort_by'] = "popularity.desc"
        req.params['include_adult'] = 'false'
      end
      json_1 = JSON.parse(response_1.body, symbolize_names: true)
      search_results_page_1 = json_1[:results]
  
      response_2 = Faraday.get('https://api.themoviedb.org/3/discover/movie') do |req|
        req.params['api_key'] = ENV['MOVIE_DB_KEY']
        req.params['sort_by'] = "popularity.desc"
        req.params['include_adult'] = 'false'
        req.params['page'] = 2
      end
      json_2 = JSON.parse(response_2.body, symbolize_names: true)
      search_results_page_2 = json_2[:results]

      @movies = search_results_page_1 + search_results_page_2
    end
  end

  def search
    response_1 = Faraday.get('https://api.themoviedb.org/3/search/movie') do |req|
      req.params['api_key'] = ENV['MOVIE_DB_KEY']
      req.params['language'] = 'en'
      req.params['include_adult'] = 'false'
      req.params['query'] = params[:title]
    end
    json_1 = JSON.parse(response_1.body, symbolize_names: true)
    search_results_page_1 = json_1[:results]

    response_2 = Faraday.get('https://api.themoviedb.org/3/search/movie') do |req|
      req.params['api_key'] = ENV['MOVIE_DB_KEY']
      req.params['language'] = 'en'
      req.params['include_adult'] = 'false'
      req.params['query'] = params[:title]
      req.params['page'] = 2
    end
    json_2 = JSON.parse(response_2.body, symbolize_names: true)
    search_results_page_2 = json_2[:results]

    search_results = search_results_page_1 + search_results_page_2

    redirect_to movies_path(results: search_results)
  end
end
