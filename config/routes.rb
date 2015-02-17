Myflix::Application.routes.draw do
  root to: 'pages#front'
  get 'register',       to: 'users#new'
  get '/login',       to: 'sessions#new'
  post '/login',        to: 'sessions#create'
  get '/logout',        to: 'sessions#destroy'
  get '/home',          to: 'videos#index'
  get '/videos/:id',           to: 'videos#show'


  resources :videos, except: [:destroy] do 
    collection do
      post :search, to: "videos#search"
    end
  resources :reviews, only: [:create]  
  end
  get 'ui(/:action)', controller: 'ui'
  resources :categories, only: [:show]
  resources :users, only: [:create] 
  resources :sessions, ony: [:create]
  
   
end