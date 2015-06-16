Rails.application.routes.draw do
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :entries
  resources :comments,      only: [:destroy, :create]
  resources :sessions,      only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  root to: 'users#index'
  get "home" => 'static_pages#home'
  get "about" => 'static_pages#about'
  get "contact" => 'static_pages#contact'
  get "help" => 'static_pages#help'
  get "signup" => 'users#new'
  get "login" => 'sessions#new'
  post "login" => 'sessions#create'
  delete "logout" => 'sessions#destroy'
  
end
