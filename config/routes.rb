Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :books
  root to: 'books#index'
end
