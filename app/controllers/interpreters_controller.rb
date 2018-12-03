class InterpretersController < BaseUsersController
  before_action :set_user, only: [:show, :create, :update]	
  def index	
    @interpreters = User.where(interpreter: true).select { |i| i.online? } # TODO improve performance	
  end	
  
  def show
    @user = User.find(params[:id])
    @interpreter = @user.interpreter_profile
  end	
  
  def new	
    @interpreter = InterpreterProfile.new	
  end	
  
  def edit	
    @user = User.find(params[:id])
    @interpreter = @user.interpreter_profile	
  end	

  def create	
    @interpreter = InterpreterProfile.new(interpreter_params)	
    @interpreter.user = current_user	
    @interpreter.save	
    redirect_to :root	
  end

  def update	
    @interpreter.update(interpreter_params)	
    redirect_to :root
  end

  def set_user
    @interpreter = current_user.interpreter_profile
  end

  def interpreter_params	 
    params.require(:interpreter).permit(:language, :certifications, :bio, :gender)	   
  end
end