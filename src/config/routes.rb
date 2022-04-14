Rails.application.routes.draw do
  root 'homes#index'
  resources :clients, only: [:show, :new, :create]
end
