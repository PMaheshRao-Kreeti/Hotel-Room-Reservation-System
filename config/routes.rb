Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  # custom routes

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/admin_login', to: 'sessions#admin_new'
  post '/admin_login', to: 'sessions#create_admin'

  # facbook authentication
  get '/auth/:provider/callback', to: 'sessions#facebook_callback'

  get '/admins', to: 'admins#index'

  get '/customers', to: 'customers#index'

  # booking routes
  get '/bookings', to: 'bookings#index'
  get '/bookings/history', to: 'bookings#booking_history'
  post 'availibility_checking', to:'bookings#availibility_checking'
  post 'bookings/:id/cancelled', to: 'bookings#cancelled', as: 'booking_cancelled'
  
  resources :hotels do
    resources :bookings, only: %i[new create edit update destroy]
    get '/bookings/:id/', to: 'bookings#approval'
  end


  # rooms routes
  get '/hotels/:id/show_rooms', to: 'hotels#show_rooms', as: 'hotel_rooms'
  resources :rooms

  resources :galleries, only: [:index]
end
