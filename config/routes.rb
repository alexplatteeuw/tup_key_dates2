Rails.application.routes.draw do
  devise_for :users
  root to: 'tups#new'
  
  resources :tups, only: [:index, :new, :show, :create]
end
