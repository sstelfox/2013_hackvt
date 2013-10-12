BikeReports::Application.routes.draw do
  devise_for :users
  root 'pages#landing'
  resources :bikes
end
