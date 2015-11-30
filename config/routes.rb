Rails.application.routes.draw do
  devise_for :users
  ActiveAdmin.routes(self)
  root 'blogs#index'

  resources :listings, only: [:new, :create]

  resources :events, only: [:new, :create]

  resources :blogs
  resources :articles

  get '/search', to: 'static_pages#search', as: :search_page
  get '/add_event', to: 'static_pages#add_event'
  get '/event', to: 'static_pages#event'

  get '/add_listing', to: 'static_pages#add_listing'

end
