Boilerman::Engine.routes.draw do
  get 'checks', to: "checks#index"
  get 'checks/inheritance_check'
  get 'checks/csrf'

  root to: "actions#index"
  resources :actions, only: :index
  resources :controllers, only: :index
end
