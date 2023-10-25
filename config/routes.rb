Rails.application.routes.draw do
  devise_for :users
  
  root "home#index"
  resources :cars do
     resources :reviews
  end

  resources :rentals
  resources :inquiries
end
