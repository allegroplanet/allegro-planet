Rails.application.routes.draw do
  root 'welcome#index'

  get '/depot', to: 'games#index'
  get '/depot/games/:slug', to: 'games#show'

  resources :users, param: :slug, only: [:show]
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
end
