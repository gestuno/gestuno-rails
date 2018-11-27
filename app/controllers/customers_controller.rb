class CustomersController < ApplicationController
  def show
    User.find(params[:id])
  end
end
