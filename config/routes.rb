Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # config/routes.rb
  namespace :api do
    post 'register', to: 'users#register'
    post 'login', to: 'users#login'
    
    resources :users, only: [] do
      resources :reservations, only: [:index, :create]
    end
    resources :reservations, only: [:destroy]
    resources :motorcycles, only: [:index, :show, :create, :destroy]
  end
end