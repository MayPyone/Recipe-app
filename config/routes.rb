Rails.application.routes.draw do
  resources :foods
  devise_for :users
  resources :reciipes do
    resources :ingredients
  end

  get "up" => "rails/health#show", as: :rails_health_check

  get '/public_reciipes', to: 'reciipes#public_reciipes'

  get '/shopping_list', to: 'foods#shopping_list', as: :shopping_list_foods

  root "home#index"
end
