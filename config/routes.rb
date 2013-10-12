BikeReports::Application.routes.draw do
  root 'pages#landing'

  get '/register', to: 'registration#new', as: :registrations
  post '/register', to: 'registration#create'

  resources :bikes do
    member do
      get :report_stolen, as: :report_stolen, action: :report_stolen
    end
  end
end
