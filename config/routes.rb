Rails.application.routes.draw do
  root'home#index'
  # get 'pg_building/index'
  get 'owner/new'
  
  # routes for user controller
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # routes for owners controller
  resources :owners do
    member do
      put'activate'
      put'deactivate'
    end
  end

  #routes for pg-buildings controller
  resources :pg_buildings do
    member do
      get 'list'
    end
  end

  #routes for payments and for downloading invoice
  resources :payments, only: [:new, :create]
  get 'payments/:id/download_invoice', to: 'payments#download_invoice', as: 'download_invoice'

  #routes for searching and filtering the pg buildings
  get 'search_buildings', to: 'pg_buildings#search', as: 'search_buildings'
  get 'filter_buildings', to: 'pg_buildings#filter', as: 'filter_buildings'

  #routes for rooms
  resources :available_rooms

  #routes for bookings
  resources :bookings do
        member do
            put 'complaints'
            get 'list'
        end
  end

  #routes to calculate price of the room
  post '/calculate_price', to: 'bookings#calculate_price'
    # member do
    #   post 'calculate_price'
    # end
  # end

  #routes for room types
  resources :room_types

  #routes for room categories
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
