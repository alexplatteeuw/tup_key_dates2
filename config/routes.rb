Rails.application.routes.draw do
  root to: 'companies#index'
  devise_for :users
  resources :tups, only: [ :new, :create, :destroy ]
  resources :companies
end
