Rails.application.routes.draw do
  # each client will have a different homepage
  root 'client/sites#show'

  namespace :admin do
    resources :appointments
    resources :users
  end

  namespace :client do
    resources :users, only: [:new, :show]
    resources :sites
  end

  resources :sessions, only: [:new, :create, :destroy]

  # get 'sites/index'
  # get 'sites/show'
  get 'signup', to: 'client/users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
