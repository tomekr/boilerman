Boilerman::Engine.routes.draw do
  root to: "controllers#index"
  resources :actions, only: :index
  resources :controllers, only: :index
end
