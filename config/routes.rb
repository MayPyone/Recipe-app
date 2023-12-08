Rails.application.routes.draw do
  resources :foods, except: [:update, :edit]
  devise_for :users
  resources :reciipes

  get "up" => "rails/health#show", as: :rails_health_check

  get '/public_reciipes', to: 'reciipes#public_reciipes'

  root "foods#index"
end
