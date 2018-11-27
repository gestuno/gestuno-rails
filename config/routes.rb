Rails.application.routes.draw do
  get 'interpreters/show'
  get 'interpreters/index'
  get 'customers/show'
  # TODO - delete this temp route once code is in correct file
  get 'pages/endcall'
  root to: 'homes#home' # redirects to other pages depending on user type/login status

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users # includes [edit, new, create, update, destroy] for all types of profile
  resources :customers, only: [:show, :index]
  resources :interpreters, only: [:show, :index]

  # resources :calls, only: []

  # get calls
  # get calls

  # resources :interpreter_profiles, only: []

end
