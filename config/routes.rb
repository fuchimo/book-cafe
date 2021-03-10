Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  
  root to: "books#index"
  resources :users, only: [:show] do
    resources :addresses, only: [:edit, :update]
  end
  
  resources :books do
    resources :reviews, only: [:edit, :update]
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end
  
end
