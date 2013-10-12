BikeReports::Application.routes.draw do
  root 'bikes#index'

  get '/register', to: 'registration#new', as: :registrations
  post '/register', to: 'registration#create'

  resources :bikes do
    collection do
      get :search, as: :search, action: :search
      post :search, as: :perform_search, action: :perform_search
    end
    member do
      get :report_stolen, as: :report_stolen, action: :report_stolen
    end
  end
end
