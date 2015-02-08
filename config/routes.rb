Myflix::Application.routes.draw do
  root to: 'pages#front'
  get 'register',     to: 'users#new'
  get 'log_in',       to: 'sessions#new'
  get '/home',        to: 'videos#index'

  resources :videos, except: [:destroy] do 
    collection do
      post :search, to: "videos#search"
    end
  end
  get 'ui(/:action)', controller: 'ui'
  resources :categories, only: [:show]
  resources :users, only: [:create] 
  
   
end