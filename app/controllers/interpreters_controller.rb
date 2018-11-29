class InterpretersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def show
    @interpreter = User.find(params[:id])
  end

  def index
    @interpreters = InterpreterProfile.all.select { |i| i.user.online? } # TODO improve performance
    # raise
  end
end
