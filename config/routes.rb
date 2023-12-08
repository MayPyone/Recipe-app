Rails.application.routes.draw do
  resources :foods, except: [:update, :edit]
  devise_for :users
  resources :reciipes, except: [:edit] do
    resources :foods_reciipes, only: [:new, :create, :destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check

  get '/public_reciipes', to: 'reciipes#public_reciipes'

  get '/general_shopping_list', to: "foods_reciipes#general_shopping_list"

  root "foods#index"
end
