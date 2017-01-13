Rails.application.routes.draw do
  root 'welcome#index'

  resources :users, param: :slug, only: [:show]
end
