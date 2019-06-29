Rails.application.routes.draw do
  resources :users
  resources :requests
  resources :jobs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
