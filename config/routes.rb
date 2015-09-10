Boilerman::Engine.routes.draw do
  root to: "actions#index"
  resources :actions, only: :index
  resources :controllers, only: :index
end
