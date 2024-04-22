Rails.application.routes.draw do
  get 'pg_building/index'
  get 'owner/new'
  root'home#index'
  devise_for :users
  resources :owner do
    member do
      get 'activate'
      get 'deactivate'
    end
  end
  # resources :pg_building
  get "pg_building/:id",to:"pg_building#index"
  # get "/owner/pg", to:"pg_building#index"
  # get 'owner'
  # post 'owner', to:'owner#create'
  # get 'owner' , to: 'owner#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
