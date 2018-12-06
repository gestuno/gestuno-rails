Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ActionCable.server => '/cable'


  root to: 'homes#home' # redirects to other pages depending on user type/login status

  devise_for :users, controllers: { registrations: 'user/registrations' }  # includes [edit, new, create, update, destroy] for all types of profile

  get 'interpreters', to: 'user_views#index'
  get 'customers', to: 'user_views#index'
  get 'users/:id', to: 'user_views#show'

  get 'start', to: 'calls#start'
  get 'join', to: 'calls#join'

  get 'about', to: 'pages#aboutus'

  get 'dashboard', to: 'user_views#dashboard', as: 'dashboard'
  patch 'dashboard', to: 'user_views#update', as: 'dash_update'

  resources :calls, only: [:create]

  patch 'calls/:call_id/attachtwiliosid', to: 'calls#attach_twilio_sid'

  get 'api/v1/twiliojwt', to: 'calls#get_twilio_jwt'

  # TODO: fix with proper namespacing
  # namespace :api do
  #   namespace :v1 do
  #     get 'twiliojwt', to: 'calls#get_twilio_jwt'
  #   end
  # end

  get 'endcall', to: 'calls#end_call'

  get "icons/star_:pct", to: "icons#star", format: :svg


  #Reviews TODO
  resources :users do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [ :show, :edit ]


end
