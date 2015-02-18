Myflix::Application.routes.draw do
  root to: 'pages#front'
  get 'register',       to: 'users#new'
  get '/login',       to: 'sessions#new'
  post '/login',        to: 'sessions#create'
  get '/logout',        to: 'sessions#destroy'
  get '/home',          to: 'videos#index'



  resources :videos, except: [:destroy] do 
    collection do
      post :search, to: "videos#search"
    end
  resources :reviews, only: [:create]
  resources :videos, only:  [:show]
  end
  get 'ui(/:action)', controller: 'ui'
  resources :categories, only: [:show]
  resources :users, only: [:create] 
  resources :sessions, ony: [:create]
  resources :queue_items, only: [:index]
  
   
end