Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/register', to: 'users#new'
  get '/discover', to: 'users#show'
  resources :users, only: :create

  resources :friendships, only: :create
  resources :movies, only: [:index, :show]
  resources :parties, only: [:new, :create]

  # post '/parties/new', to: 'parties#create'
  # post '/dashboard', to: 'parties#create'


  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#show'

  get '/search', to: 'movies#search'
end
