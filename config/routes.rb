Rails.application.routes.draw do
  devise_for :users

  root 'static_pages#search'

  resources :listings, only: [:new, :create] do
  end

  get '/search', to: 'static_pages#search', as: :search_page
  get 'add_event', to: 'static_pages#add_event'

end
