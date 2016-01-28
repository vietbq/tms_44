Rails.application.routes.draw do

  get "about" => "static_pages#about"
  get "help" => "static_pages#help"
  root "static_pages#about"

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  resources :users, only: [:edit, :update]
  resources :users, only: [:show] do
    resources :user_courses, only: [:show]
  end
  resources :password_resets, except: [:destroy, :index]
  resources :user_courses, only: [:index]
  resources :courses, only: [:show] do
    resources :members, only: [:index]
  end
  resources :user_subjects, only: [:index]
  resources :user_subjects, only: [:show] do
    resources :course_subject_tasks
  end

  namespace :admin do
    get "login" => "sessions#new"
    post "login" => "sessions#create"
    delete "logout"  => "sessions#destroy"
    root "static_pages#dashboard"
    resources :superusers
    resources :users
    resources :subjects, except: [:show]
    resources :courses do
      resources :superuser_courses, only: [:new, :create]
      resources :user_courses, only: [:new, :create, :destroy]
      resources :user_subjects, only: [:create]
    end
  end
end
