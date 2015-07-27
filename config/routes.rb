Rails.application.routes.draw do
  devise_for :users

  root 'static_pages#search'

  get '/search', to: 'static_pages#search', as: :search_page

  get '/add_event', to: 'static_pages#add_event'

  get '/event', to: 'static_pages#event'
  
  get '/add_listing', to: 'static_pages#add_listing'

  get '/new_listing', to: 'listings#new', as: :new_listing

end
