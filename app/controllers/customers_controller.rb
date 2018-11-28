class CustomersController < ApplicationController
  before_action :set_customer, only: [ :show ]
  
  def index
    @customers = User.all.select { |user| user.customer? && user.online? }
    # raise
  end

  def show
  end

  private
  
  def set_customer
    @customer = User.find(params[:id])
  end

end
