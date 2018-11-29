class CallsController < ApplicationController

  include CallsHelper

  def get_twilio_jwt
    render json: JSON.generate(CallsHelper.get_twilio_jwt)
  end

  def create
    room_name = SecureRandom.uuid

    @call = Call.create(sender: User.first, recipients: [User.second], room_name: room_name, twilio_sid: room_name + 'twilio')

    session[:call_id] = @call.id

    redirect_to "/start/#{room_name}"
  end

  def start
  end

  def join
  end

  # def update
  #   @call = Call.new
  # end

end
