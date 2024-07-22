Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy', as: :custom_destroy_user_session
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :cars
  resources :users do
    resources :cars, only: :index
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "cars#index"
end
