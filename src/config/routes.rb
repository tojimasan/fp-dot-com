Rails.application.routes.draw do
  root 'homes#index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :clients, only: [:show, :new, :create]
  resources :financial_planners, only: [:show, :new, :create]
  resources :consultation_appointment_slots, only: [:index, :new, :create, :edit, :update]
end
