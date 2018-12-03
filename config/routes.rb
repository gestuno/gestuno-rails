Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ActionCable.server => '/cable'


  root to: 'homes#home' # redirects to other pages depending on user type/login status

  devise_for :users, controllers: { registrations: 'user/registrations' }  # includes [edit, new, create, update, destroy] for all types of profile

  # devise_scope :user do
  #   get 'profile', to: 'devise/registrations#edit'
  # end

  resources :customers, only: [:index, :edit, :show, :update]
  resources :interpreters, only: [:index, :edit, :show, :update]

  get 'start', to: 'calls#start'
  get 'join', to: 'calls#join'

  resources :calls, only: [:create]

  patch 'calls/:call_id/attach_twilio_sid', to: 'calls#attach_twilio_sid'
  # get 'calls/:call_id/append_twilio_info', to: 'calls#join'

  get 'api/v1/twiliojwt', to: 'calls#get_twilio_jwt'

  # TODO: fix with proper namespacing
  # namespace :api do
  #   namespace :v1 do
  #     get 'twiliojwt', to: 'calls#get_twilio_jwt'
  #   end
  # end

  # TODO - delete this temp route once code is in correct file
  get 'endcall', to: 'calls#end_call'

end
