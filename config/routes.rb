Rails.application.routes.draw do
  
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  # For follow and unfollow
  resources :relationships, only: [:create, :destroy]
  # localhost:3000 -> docker: localhost: 3002
  root 'static_pages#home'

  # localhost:3000/about
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  # localhost:3000/signup
  get '/signup', to: 'users#new'

  get '/signup', to: 'user#new'


  get '/login', to: 'sessions#new'

  get '/logout', to: 'sessions#destroy'


  resources :users
  # Sessions
  resources :sessions, only:[:new, :create, :destroy]

  # Microposte
  resources :microposts, only: [:create, :destroy]

  # http_action '/route_name', to: 'controller#page#'

  # get 'static_pages/home'
  # get 'static_pages/about'
  # get 'static_pages/contact'
  
  resources :users do
    member do
      get :following, :followers
    end
   
  end
end
