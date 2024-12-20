require 'sidekiq/web'

Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'


  resources :posts
  get '/index_by_users',to: 'posts#index_by_users'
  get '/randomize_posts',to: 'posts#randomize_posts'
  post '/search_posts',to: 'posts#search_posts'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"

  post '/login',to: 'authentication#login'
  get '/current',to: 'users#show_current_user'
  delete '/logout',to: 'sessions#logout_user'
  resources :users
  resources :liked_posts
  post '/like_post',to: 'liked_posts#like_post'
  resources :categories
  resources :notifications
end
