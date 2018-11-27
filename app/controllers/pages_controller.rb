class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :endcall]

  def home
  end

  def endcall
  end
end
