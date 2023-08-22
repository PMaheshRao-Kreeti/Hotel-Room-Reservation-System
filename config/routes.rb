# frozen_string_literal: true

# rubocop:disable all
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root 'welcome#index'

  get '/admins', to: 'welcome#admin_index' 
  get '/customers', to: 'welcome#customer_index'
  get '/galleries', to: 'welcome#gallery'

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

  # booking routes
  get '/bookings', to: 'bookings#index'
  get '/bookings/history', to: 'bookings#booking_history'
  post 'availibility_checking', to: 'bookings#availibility_checking'
  post 'bookings/:id/cancelled', to: 'bookings#cancelled', as: 'booking_cancelled'

  resources :hotels do
    get '/show_rooms', to: 'hotels#show_rooms', as: 'show_rooms'
    
    # rooms routes
    resources :rooms, except: %i[index show]
  
    # booking routes
    get '/bookings/:id/', to: 'bookings#approval', as: 'booking_approval'
    resources :bookings, only: %i[new create update destroy]
    
    collection do
      get :search
      get :filter
    end
  end

  # notification
  post 'markread', to: 'bookings#markread'

end
# rubocop:enable all
