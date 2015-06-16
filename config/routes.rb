Rails.application.routes.draw do
  resources :entries
  resources :users
  root to: 'static_pages#home'
  resources :sessions, only: [:new, :create, :destroy]

  get "home" => 'static_pages#home'
  get "about" => 'static_pages#about'
  get "contact" => 'static_pages#contact'
  get "help" => 'static_pages#help'
  get "signup" => 'users#new'
  get "login" => 'sessions#new'
  post "login" => 'sessions#create'
  delete "logout" => 'sessions#destroy'
  
end
