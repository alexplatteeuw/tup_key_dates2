Rails.application.routes.draw do
  root to: 'tups#new'
  devise_for :users
  resources :tups, only: [:index, :new, :show, :create]
  resources :companies
end
