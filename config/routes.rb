Rails.application.routes.draw do
  get 'sessions/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#home"
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get  '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :posts, only: [:create, :destroy]
  get 'search_users', to: 'users#search'
  get 'goto_users', to: 'users#search'
  get 'users/:id/friend', to: 'friendship#create'
  resources :friendship, only: [:destroy]
  get 'delete/:id', to: 'friendship#delete', as: 'delete'
  get 'accept/:id', to: 'friendship#accept', as: 'accept'
  get 'decline/:id', to: 'friendship#decline', as: 'decline'
  get 'cancel/:id', to: 'friendship#cancel', as: 'cancel'
end
