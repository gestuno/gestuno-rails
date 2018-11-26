class HomesController < ApplicationController
  def home
    redirect_to 'pages#home'
  end
end
