Rails.application.routes.draw do
  get "about" => "static_pages#about"
  get "help" => "static_pages#help"
  root "static_pages#about"

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  resources :users
  resources :password_resets, except: [:destroy, :index]
  resources :user_courses, only: [:index]
  resources :courses, only: [:show]   do
    resources :members, only: [:index]
  end

  namespace :admin do
    get "login" => "sessions#new"
    post "login" => "sessions#create"
    delete "logout"  => "sessions#destroy"
    root "sessions#new"
    resources :superusers
  end
end
