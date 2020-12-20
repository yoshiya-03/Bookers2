Rails.application.routes.draw do
  devise_for :users
  root to: 'home#top'
  get 'home/about'
  resources :users, only: [:show, :edit, :update, :index, :create]
  resources :books
end
