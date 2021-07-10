class MoviesController < ApplicationController
  def index
    if params[:results]
      @movies = params[:results]
    else
      response1 = Faraday.get('https://api.themoviedb.org/3/discover/movie') do |req|
        req.params['api_key'] = ENV['MOVIE_DB_KEY']
        req.params['sort_by'] = 'popularity.desc'
        req.params['include_adult'] = 'false'
      end
      json1 = JSON.parse(response1.body, symbolize_names: true)
      search_results_page1 = json1[:results]

      response2 = Faraday.get('https://api.themoviedb.org/3/discover/movie') do |req|
        req.params['api_key'] = ENV['MOVIE_DB_KEY']
        req.params['sort_by'] = 'popularity.desc'
        req.params['include_adult'] = 'false'
        req.params['page'] = 2
      end
      json2 = JSON.parse(response2.body, symbolize_names: true)
      search_results_page2 = json2[:results]

      @movies = search_results_page1 + search_results_page2
    end
  end

  def search
    response1 = Faraday.get('https://api.themoviedb.org/3/search/movie') do |req|
      req.params['api_key'] = ENV['MOVIE_DB_KEY']
      req.params['language'] = 'en'
      req.params['include_adult'] = 'false'
      req.params['query'] = params[:title]
    end
    json1 = JSON.parse(response1.body, symbolize_names: true)
    search_results_page1 = json1[:results]

    response2 = Faraday.get('https://api.themoviedb.org/3/search/movie') do |req|
      req.params['api_key'] = ENV['MOVIE_DB_KEY']
      req.params['language'] = 'en'
      req.params['include_adult'] = 'false'
      req.params['query'] = params[:title]
      req.params['page'] = 2
    end
    json2 = JSON.parse(response2.body, symbolize_names: true)
    search_results_page2 = json2[:results]

    search_results = search_results_page1 + search_results_page2

    redirect_to movies_path(results: search_results)
  end
end
