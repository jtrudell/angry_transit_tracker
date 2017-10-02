Rails.application.routes.draw do
  root to: 'pages#home'
  resources :bus_routes, only: :show
end
