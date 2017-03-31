Rails.application.routes.draw do
  get 'bets/index'

  devise_for :users
  get 'user' => 'user#index'
  patch 'user' => 'user#update'

  root to: "home#index"

  resources :users, only: [] do
    resources :portfolios, only: [:index]
  end

  resources :portfolios, only: [:show, :new, :create, :update, :destroy]
  resources :currencies, only: :index


  resources :bets, only: [:new, :index, :show, :create]

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
