Rails.application.routes.draw do
  root to: 'tups#new'
  
  post '/tups1', to: 'tups#compute_from_publication'
  post '/tups2', to: 'tups#compute_from_legal_effect'
  resources :tups, only: [:index, :new, :show, :create]
end
