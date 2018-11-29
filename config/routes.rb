Rails.application.routes.draw do
  # TODO - delete this temp route once code is in correct file
  get 'pages/endcall'
  root to: 'homes#home' # redirects to other pages depending on user type/login status

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users  # includes [edit, new, create, update, destroy] for all types of profile
  devise_scope :user do
    get 'profile', to: 'customers#show'
  end
  resources :customers, only: [:show, :index]
  resources :interpreters, only: [:show, :index]

  get 'twiliojwt', to: 'calls#get_twilio_jwt'

  get 'twiliotest', to: 'pages#twilio_test'

  # resources :interpreter_profiles, only: []

end
