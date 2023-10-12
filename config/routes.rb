# frozen_string_literal: true

# rubocop:disable all
Rails.application.routes.draw do 
  root 'welcome#index'
  # signup and login routes routes
  get '/signup', to: 'users#new' 
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/admin_login', to: 'sessions#admin_new'
  post '/admin_login', to: 'sessions#create_admin'
  
  # facbook authentication
  get '/auth/:provider/callback', to: 'sessions#facebook_callback'

  get '/customers', to: 'welcome#customer_index'
  
  # admin routes
  resources :admins, only: %i[ new create destroy]
  get '/admins', to: 'admins#admin_index' 
  get '/admin/management', to: 'admins#hotel_admin_management'
  
  resources :hotels do
    get '/show_rooms', to: 'hotels#show_rooms', as: 'show_rooms'
    # rooms routes
    resources :rooms, except: %i[index show]
    # booking routes
    resources :bookings, only: %i[new create update]
    get '/bookings_details', to: 'bookings#details', as: 'booking_details'
    get '/booking/:id/more_info', to: 'bookings#show', as: 'and_user_more_info'
    get '/bookings/:id/approval', to: 'bookings#approval', as: 'booking_approval'
    
    collection do
      get :search
      get :filter
    end
  end
  
  # booking routes
  get '/bookings', to: 'bookings#index'
  get '/bookings/history', to: 'bookings#booking_history'
  post 'availibility_checking', to: 'bookings#availibility_checking'
  post 'bookings/:id/cancelled', to: 'bookings#cancelled', as: 'booking_cancelled'

  resources :images, only: %i[new create destroy]

  # notification
  post 'markread', to: 'bookings#markread'

  # match '*unmatched', to: 'application#not_found', layout: false, via: :all, constraints: lambda { |req|
  #   req.path.exclude? 'rails/active_storage' # Exclude Active Storage routes
  # }
end
# rubocop:enable all
