Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/register', to: 'users#new'
  
  resources :users, only: :create

  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login'
end
