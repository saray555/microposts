Rails.application.routes.draw do
  get 'users/new'

  root to: 'static_pages#home'
  get    'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  patch  'users/:id', to: 'users#update'
  delete 'logout', to: 'sessions#destroy'

  resources :users
  resources :microposts
end
