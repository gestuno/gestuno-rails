class InterpretersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  before_action :set_user, only: [:show, :edit, :create, :update]

  def index
    @interpreters = InterpreterProfile.all.select { |i| i.user.online? } # TODO improve performance
  end

  def show
  end

  def new
    @interpreter = InterpreterProfile.new
  end

  def edit
  end

  def create
    # @interpreter = InterpreterProfile.new(interpreter_params)
    # @interpreter.user = User.find(params(:user_id))
    # @interpreter.save
    # redirect_to
  end

  def update
    @interpreter.update(interpreter_params)
  end

  private

  def set_user
    @interpreter = current_user
  end

  def interpreter_params
    params.require(:interpreter).permit(:language, :certifications, :bio, :gender)
  end


  # def set_user
  #   @user = User.find(params[:id])
  # end

end
