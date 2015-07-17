Rails.application.routes.draw do
  devise_for :users

  root 'static_pages#search'

  get '/search', to: 'static_pages#search', as: :search_page

  get '/new_listing', to: 'listings#new', as: :new_listing

end
