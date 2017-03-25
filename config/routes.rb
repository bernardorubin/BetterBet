Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"
  get '/' => 'main#index'

  resources :stocks, only: :index
  resources :currencies, only: :index

end
