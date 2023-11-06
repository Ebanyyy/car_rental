Rails.application.routes.draw do
  get 'transactions/new'
  get 'howtobook', to: 'customer/home#howtobook'
  get 'about', to: 'customer/home#about'

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
    resources :transactions, only: [:new, :create]
  end
end
