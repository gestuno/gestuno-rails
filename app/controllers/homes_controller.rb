class HomesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if !user_signed_in?
      render 'pages/home'
    elsif current_user.customer?
      redirect_to :interpreters
    elsif current_user.interpreter?
      redirect_to :customers
    end
  end
end
