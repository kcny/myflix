Myflix::Application.routes.draw do
  root to: 'pages#front'
  get '/home',          to: 'videos#index'


  resources :videos, except: [:destroy] do 
    collection do
      post :search, to: "videos#search"
    end
    resources :reviews, only: [:create]
  end

  get '/people', to: 'relationships#index'

  resources :users, only: [:show]
  resources :categories, only: [:show]
  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'

  get 'my_queue', to: 'queue_items#index'

  get 'ui(/:action)', controller: 'ui'
  get 'register',       to: 'users#new'
  get '/login',       to: 'sessions#new'
  post '/login',        to: 'sessions#create'
  get '/logout',        to: 'sessions#destroy'
  
  resources :users, only: [:create] 
  resources :sessions, ony: [:create]
end