Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'homes#home' # redirects to other pages depending on user type/login status
  
  devise_for :users, controllers: { registrations: 'user/registrations' }  # includes [edit, new, create, update, destroy] for all types of profile
  devise_scope :user do
    get 'profile', to: 'devise/registrations#edit'
  end
  
  resources :customers, only: [:show, :index]
  resources :interpreters, only: [:show, :index]
  
  # PROFILE routes
  # get 'interpreter_signup', to: 'devise/registrations#new'
  # get 'customer_signup', to: 'devise/registrations#new'
  
  # TWILIO routes
  get 'twiliojwt', to: 'calls#get_twilio_jwt'
  get 'twiliotest', to: 'pages#twilio_test'
  
  # TODO - delete this temp route once code is in correct file
  get 'pages/endcall'
  
  # resources :interpreter_profiles, only: []

end
