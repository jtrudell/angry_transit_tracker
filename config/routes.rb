Rails.application.routes.draw do
  root to: 'pages#home'
  get 'bus_routes/search' => 'bus_routes#search'
  resources :bus_routes, only: :show

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
