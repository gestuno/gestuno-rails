class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def endcall
  end

  def twilio_test
    # render 'pages/index'
  end

end
