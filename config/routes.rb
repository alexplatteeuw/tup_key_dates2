Rails.application.routes.draw do
  post '/tups2', to: 'tups#display_publications'

  root to: 'tups#new'
  resources :tups, only: [:index, :new, :show, :create]
end
