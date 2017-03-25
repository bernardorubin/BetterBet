Rails.application.routes.draw do
  devise_for :users
  get 'user' => 'user#index'
  patch 'user' => 'user#update'

  root to: "home#index"

  resources :portfolio, only: [:index, :show, :new]
  resources :currencies, only: :index

  # resources :sessions, only: [:new, :create] do
  #   delete :destroy, on: :collection
  # end


end
