Boilerman::Engine.routes.draw do
  root to: "controllers#index"
  get 'controllers/index'

  resources :actions, only: :index
end
