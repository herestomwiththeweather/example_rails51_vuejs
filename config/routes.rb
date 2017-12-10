Rails.application.routes.draw do
  get '/login' => 'sessions#new', as: :login
  get '/logout' => 'sessions#destroy', as: :logout
  get '/callback' => 'sessions#callback', as: :callback

  resources :employees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :teams

  root 'employees#index'
end
