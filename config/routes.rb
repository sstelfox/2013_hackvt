BikeReports::Application.routes.draw do
  root 'pages#landing'

  get '/faq', to: 'pages#faq'

  get '/search', to: 'search#new', as: :search
  post '/search', to: 'search#create'

  get '/register', to: 'registration#new', as: :registrations
  post '/register', to: 'registration#create'

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  delete '/logout', to: 'sessions#destroy'

  get '/report_stolen', to: 'incidents#new', as: :report_stolen
  post '/report_stolen', to: 'incidents#create'

  get '/found_bike', to: 'found#new', as: :found_bike
  post '/found_bike', to: 'found#create'

  resources :bikes do
    collection do
      get :report_stolen, as: :report_stolen, action: :report_stolen
    end

    member do
      get '/craigslist', to: 'bikes#craigslist'
      get '/qr', to: 'bikes#qr'

      get '/report_stolen', to: 'incidents#new', as: :report_stolen
      post '/report_stolen', to: 'incidents#create'
      get '/report_returned', to: 'bikes#report_returned'
      get '/craigslist', to: 'bikes#craigslist'

      get '/transfer', to: 'transfers#new', as: :transfer
      post '/transfer', to: 'transfers#create'
    end
  end
end
