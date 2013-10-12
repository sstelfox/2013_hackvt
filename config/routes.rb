BikeReports::Application.routes.draw do
  root 'bikes#index'

  get '/register', to: 'registration#new', as: :registrations
  post '/register', to: 'registration#create'

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  delete '/logout', to: 'sessions#destroy'

  resources :bikes do
    collection do
      get :report_stolen, as: :report_stolen, action: :report_stolen
      get :search, as: :search, action: :search
      post :search, as: :perform_search, action: :perform_search
    end
  end
end
