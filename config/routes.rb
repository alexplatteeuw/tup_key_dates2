Rails.application.routes.draw do
  post '/tups1', to: 'tups#create_from_publication'
  post '/tups2', to: 'tups#create_from_legal_effect'

  root to: 'tups#index'
  resources :tups, only: [:index, :show]
end
