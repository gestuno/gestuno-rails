class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :aboutus]

  def home
  end

  def index
  end

  def aboutus
  end

end
