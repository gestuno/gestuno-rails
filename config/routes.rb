Rails.application.routes.draw do
  root to: 'homes#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users # includes [edit, new, create, update, destroy] for all types of profile
  resources :customers, only: [:show]
  resources :interpreters, only: [:show, :index]

  # resources :calls, only: []

  # get calls
  # get calls

  resources :interpreter_profiles, only: []

end
