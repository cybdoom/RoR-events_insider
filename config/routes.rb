Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: :sessions,
    registrations: :registrations
  }

  ActiveAdmin.routes(self)

  root 'articles#index'

  resources :listings, only: [:new, :create]

  resources :events, only: [:new, :create]

  resources :articles, path: :news

  get '/Boston/:slug', to: 'articles#show'

  #### REDIRECT OLD ARTICLES REQUESTS TO SEARCH
  get '/bostonevents/:year/:date/:old_slug', to: 'events#search', constraints: {
    year: /\d{4}/,
    date: /\d{2}-\d{2}/
  }
  get '/:year/:month/:old_slug', to: 'articles#search', constraints: {
    year:  /\d{4}/,
    month: /\d{2}/
  }
  ##########################

  get '/pages/:title', to: 'pages#show'

  get '/search', to: 'static_pages#search', as: :search_page
  get '/add_event', to: 'static_pages#add_event'
  get '/event', to: 'static_pages#event'

  get '/add_listing', to: 'static_pages#add_listing'

end

