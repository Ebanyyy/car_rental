Rails.application.routes.draw do
  root 'customer/home#index'

  devise_for :users

  namespace :admin do 
    resources :rentals
    resources :cars 
    resources :inquiries
  end

  namespace :customer do

    resources :cars do
       resources :reviews
    end

    resources :rentals
    resources :inquiries
  end
end
