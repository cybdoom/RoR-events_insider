Rails.application.routes.draw do
  devise_for :users

  root 'static_pages#search'

  get '/search', to: 'static_pages#search', as: :search_page

  resources :listings, only: [:new] do
  end

end
