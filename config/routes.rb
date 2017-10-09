Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'welcome#index'

  get '/search', to: 'search#index', param: :q

  resources :games, param: :handle, only: [:index, :show]

  resources :github_webhook, path: 'github-webhooks', param: :uuid, only: [] do
    resources :github_webhook_events, path: 'events', only: [:create, :index, :show]
  end

  resources :users, param: :handle, only: [:show]
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
end
