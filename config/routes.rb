Rails.application.routes.draw do
  devise_for :users
  
  root "home#index"
  resources :cars do
     resources :reviews, only: [:show, :new]
  end
  resources :rentals
end
