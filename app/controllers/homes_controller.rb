class HomesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if !@user
      render 'pages/home'
    end
  end
end
