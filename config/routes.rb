Rails.application.routes.draw do
  root to: 'pages#home'
  resources :bus_routes, only: :show do
    resources :directions, only: :index
    resources :bus_stops, only: [:index, :show]
  end
end
