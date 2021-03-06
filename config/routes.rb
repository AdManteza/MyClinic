Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # each client will have a different homepage
  root 'client/sites#show'

  namespace :admin do
    resources :appointments
    resources :patient_sessions
    resources :users

    resources :sessions, only: [:create, :destroy]
  end

  namespace :client do
    resources :sites, only: [:show]
    resources :users, only: [:new, :show]

    resources :sessions, only: [:create, :destroy]
  end

  get 'admin_logout', to: 'admin/sessions#destroy', as: 'admin_logout'
  get 'admin_dashboard', to: 'admin/admin#dashboard', as: 'admin_dashboard'
  post 'admin_login', to: 'admin/sessions#create', as: 'admin_login'

  get 'user_signup', to: 'client/users#new', as: 'user_signup'
end