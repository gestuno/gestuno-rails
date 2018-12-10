class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :aboutus]

  def home
  end

  def index
  end

  def aboutus
  end

  def registrations_disabled
    render html: <<-HTML
      <div>Sorry! Registrations are disabled at the moment.</div>
      <a href='/'>Home</a>
    HTML
      .html_safe
  end

end
