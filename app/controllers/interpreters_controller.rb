class InterpretersController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index] # todo: re-add authentication

  def show
    InterpreterProfile.find(params[:id])
  end

  def index
    @interpreters = InterpreterProfile.all
    # raise
  end
end
