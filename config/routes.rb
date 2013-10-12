BikeReports::Application.routes.draw do
  root 'pages#landing'
  resources :bikes do
    member do
      get :report_stolen, as: :report_stolen, action: :report_stolen
    end
  end
end
