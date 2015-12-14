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

  post '/tinymce_assets', to: 'pictures#create'

  get '/:page_slug', to: 'pages#show'
  get '/pages/:page_slug', to: 'pages#redirect_to_show'
end

