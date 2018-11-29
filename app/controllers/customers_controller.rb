class CustomersController < ApplicationController
  before_action :set_customer, only: [ :show, :edit, :update]

  def index
    @customers = User.all.select { |user| user.customer? && user.online? }
    # raise
  end

  def show
    @customer = User.find(set_customer)
  end

  def edit
    @customer = User.find(set_customer)
  end

  def update
    @customer = User.find(set_customer)
    @customer.update(user_params)
    redirect_to profile_path
  end

  def create

  end


  private

  def set_customer
    @customer = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :language)
  end

end
