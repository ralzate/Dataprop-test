Rails.application.routes.draw do

  get 'home/index'
  get "up" => "rails/health#show", as: :rails_health_check

  resources :properties
  devise_for :users
  
  root to: 'home#index'

end
