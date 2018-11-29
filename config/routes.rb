Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homes#home' # redirects to other pages depending on user type/login status

  devise_for :users, controllers: { registrations: 'user/registrations' }  # includes [edit, new, create, update, destroy] for all types of profile

  # devise_scope :user do
  #   get 'profile', to: 'devise/registrations#edit'
  # end

  resources :customers, only: [:index, :new, :create, :edit, :destroy, :edit, :show, :update]
  resources :interpreters, only: [:index, :new, :create, :edit, :destroy, :edit, :show, :update]

  get 'start/:room_name', to: 'calls#start'
  get 'join/:room_name', to: 'calls#join'

  resources :calls, only: [:create] #, :update

  get 'twiliojwt', to: 'calls#get_twilio_jwt'

  # TODO - delete this temp route once code is in correct file
  get 'pages/endcall'

end
