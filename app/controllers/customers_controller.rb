class CustomersController < ApplicationController
  def index
    @customers = User.all.select { |user| user.customer? && user.online? }
    # raise
  end

  def show
    User.find(params[:id])
  end
end
