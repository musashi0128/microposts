Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'signup',  to: 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  
  resources :users do
    member do
      get :followings
      get :followers
      get 'favorites' => 'users#favorite', as: 'favorites'
    end
  end
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :favoriteships, only: [:create, :destroy]
  resources :microposts, only: [:create, :destroy]
end
