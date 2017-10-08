Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'welcome#index'

  get '/search', to: 'search#index', param: :q

  resources :github_webhooks, only: [:create, :index]

  resources :games, param: :handle, only: [:index, :show]

  resources :users, param: :handle, only: [:show]
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
end
