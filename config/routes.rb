Rails.application.routes.draw do
  devise_for :users
  get 'user' => 'user#index'
  patch 'user' => 'user#update'

  root to: "home#index"

  resources :portfolios, only: [:index, :show, :new, :create, :update]
  resources :currencies, only: :index



  # resources :questions, shallow: true do
  #
  #   resources :answers, only: [:create, :destroy]
  #   resources :likes, only: [:create, :destroy]
  #   resources :votes, only: [:create, :update, :destroy]
  # end


  # resources :sessions, only: [:new, :create] do
  #   delete :destroy, on: :collection
  # end


end
