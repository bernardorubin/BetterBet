Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"
  get '/' => 'main#index'

  resources :stocks, only: :index
  resources :currencies, only: :index

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  get 'user' => 'user#index'
  patch 'user' => 'user#update'
  
end
