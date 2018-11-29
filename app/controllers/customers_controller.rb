class CustomersController < ApplicationController
  before_action :set_customer, only: [ :show, :edit, :update]

  def index
    # @customers = CustomerProfile.all.select { |c| c.customer? && u.online? }
    # TODO improve performance
    # TODO - do not use this!
  end

  def show
  end

  def edit
  end

  def update
    @customer.update(user_params)
    redirect_to profile_path
  end

  private

  def set_customer
    @customer = current_user
  end

  def user_params
    params.require(:user).permit(:language)
  end

end
