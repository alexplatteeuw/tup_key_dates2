Rails.application.routes.draw do
  root to: 'companies#index'
  devise_for :users
  resources :tups, only: [:index, :new, :create, :show ]
  resources :companies
end
