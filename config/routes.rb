Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :users, only: :create

  get '/register', to: 'users#new'
  get '/dashboard', to: 'users#show'
  
  scope module: :users do
    resources :friendships, only: :create
    resources :movies, only: [:index, :show]
    resources :parties, only: [:new, :create]
    get '/discover', to: 'discover#show'
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
