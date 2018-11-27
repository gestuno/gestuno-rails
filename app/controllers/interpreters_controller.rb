class InterpretersController < ApplicationController
  def show
    # InterpreterProfile.find(params[:id])
    User.find(params[:id]) # TODO  ActiveRecord::RecordNotFound in InterpretersController#show | Couldn't find User without an ID
  end

  def index
    @interpreters = InterpreterProfile.all.select { |i| i.user.online? } # TODO improve performance
    # raise
  end
end
