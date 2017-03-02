Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'welcome#index'

  resources :games, param: :slug, only: [:index, :show]

  resources :users, param: :slug, only: [:show]
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
end
