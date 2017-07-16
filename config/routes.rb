Rails.application.routes.draw do
  resources :employees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :teams
end
