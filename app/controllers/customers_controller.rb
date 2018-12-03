class CustomersController < BaseUsersController
  before_action :set_user, only: [:show, :create, :update]	
  # def index	
  #   @customers = User.where(customer: true).select { |i| i.online? } # TODO improve performance	
  # end	
  
  def show
    @user = User.find(params[:id])
    @customer = @user.customer_profile
  end	
  
  def new	
    @customer = customerProfile.new	
  end	
  
  def edit	
    @user = User.find(params[:id])
    @customer = @user.customer_profile	
  end	

  def create	
    @customer = customerProfile.new(customer_params)	
    @customer.user = current_user	
    @customer.save	
    redirect_to :root	
  end

  def update	
    @customer.update(customer_params)	
    redirect_to :root
  end

  def set_user
    @customer = current_user.customer_profile
  end

  def customer_params	 
    params.require(:customer).permit(:gender, :language, :avatar, :bio)	   
  end
end