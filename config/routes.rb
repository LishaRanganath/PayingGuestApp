Rails.application.routes.draw do
  get 'pg_building/index'
  get 'owner/new'
  root'home#index'
  devise_for :users
  resources :owners do
    member do
      get 'activate'
      get 'deactivate'
    end
  end
  resources :pg_buildings do
    member do
      get 'list'
    end
  end
  get 'search_buildings', to: 'pg_buildings#search', as: 'search_buildings'
  resources :available_rooms
  resources :room_bookings
  post '/calculate_price', to: 'room_bookings#calculate_price'
    # member do
    #   post 'calculate_price'
    # end
  # end
  resources :room_types
  resources :categories
  # get "pg_building/:id",to:"pg_building#index"
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
