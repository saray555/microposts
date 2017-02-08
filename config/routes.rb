Rails.application.routes.draw do
  #get 'pages/index'

  get 'users/new'
  get 'microposts/index'

  root to: 'static_pages#home'
  get    'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  patch  'users/:id', to: 'users#update'
  delete 'logout', to: 'sessions#destroy'

  resources :users do
    member do
      get :followings, :followers
    end
  end
  resources :microposts
  resources :relationships, only: [:create, :destroy]
end
