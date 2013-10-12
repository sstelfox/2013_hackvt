BikeReports::Application.routes.draw do
  root 'pages#landing'

  get '/register', to: 'registration#new', as: :registrations
  post '/register', to: 'registration#create'

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  delete '/logout', to: 'sessions#destroy'

  get '/report_stolen', to: 'incidents#new', as: :report_stolen
  post '/report_stolen', to: 'incidents#create'

  get '/found_bike', to: 'found#new', as: :found_bike

  resources :bikes, except: [:show] do
    collection do
      get :report_stolen, as: :report_stolen, action: :report_stolen
      get :search, as: :search, action: :search
      post :search, as: :perform_search, action: :perform_search
    end

    member do
      get '/report_stolen', to: 'incidents#new', as: :report_stolen
      post '/report_stolen', to: 'incidents#create'
    end
  end
end
