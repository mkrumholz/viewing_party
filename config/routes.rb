Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/register', to: 'users#new'

  resources :users, only: :create
  resources :friendships, only: [:create]


  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#show'

  get '/discover', to: 'discover#index'

  # namespace :discover do
  #   resources :movies,
  # end
end
