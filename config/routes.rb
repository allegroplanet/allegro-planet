Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'welcome#index'

  get '/search', to: 'search#index', param: :q

  resources :games, param: :handle, only: [:index, :show] do
    resources :github_webhook, path: 'github-webhooks', param: :uuid, only: [] do
      resources :github_webhook_events, path: 'events', only: [:create, :index, :show]
    end
  end

  resources :users, param: :handle, only: [:index, :show]
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
end
