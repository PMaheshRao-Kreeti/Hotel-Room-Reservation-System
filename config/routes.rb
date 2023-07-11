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

  get '/admin/dashboard', to: 'admins#index'

  resources :home, only: [:index]
  resources :customers, only: [:index]
end
