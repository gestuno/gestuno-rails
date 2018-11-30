class CustomersController < ApplicationController

  # TODO: DRY up with base user controller class

  before_action :set_user, only: [:show, :create, :update]

  def index
    @customers = User.all.select { |user| user.customer? && user.online? } # TODO improve performance
  end

  def show
  end

  def new
    @customer = CustomerProfile.new
  end

  def edit
    @customer = CustomerProfile.new()
  end

  def create
    @customer = CustomerProfile.new(customer_params)
    @customer.user = current_user
    @customer.save
    render :edit
  end

  def update
    @customer.update(customer_params)
  end

  private

  def set_user
    @customer = current_user
  end

  def customer_params
    params.require(:customer).permit(:language, :bio, :gender)
  end


  # def set_user
  #   @user = User.find(params[:id])
  # end

end
