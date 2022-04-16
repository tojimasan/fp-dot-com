Rails.application.routes.draw do
  get 'consultation_appointment_slots/new'
  get 'consultation_appointment_slots/create'
  root 'homes#index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :clients, only: [:show, :new, :create]
  resources :financial_planners, only: [:show, :new, :create]
end
