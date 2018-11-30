 class InterpretersController < ApplicationController

  # TODO: DRY up with base user controller class

  before_action :set_user, only: [:show, :create, :update]

  def index
    @interpreters = InterpreterProfile.all.select { |i| i.user.online? } # TODO improve performance
  end

  def show
  end

  def new
    @interpreter = InterpreterProfile.new
  end

  def edit
    @interpreter = InterpreterProfile.new()
  end

  def create
    @interpreter = InterpreterProfile.new(interpreter_params)
    @interpreter.user = current_user
    @interpreter.save
    render :edit
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
