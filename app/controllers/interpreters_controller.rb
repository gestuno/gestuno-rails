class InterpretersController < ApplicationController
  before_action :set_interpreter, only: [ :show ]

  def index
    @interpreters = InterpreterProfile.all.select { |i| i.user.online? } # TODO improve performance
    # raise
  end
  
  def show
  end

  private
  
  def set_interpreter
    @interpreter = User.find(params[:id])
  end

end
