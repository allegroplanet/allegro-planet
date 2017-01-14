Rails.application.routes.draw do
  root 'welcome#index'

  resources :users, param: :slug, only: [:show]
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
end
