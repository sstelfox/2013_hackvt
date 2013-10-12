BikeReports::Application.routes.draw do
  root 'pages#landing'
  resources :bikes
end
