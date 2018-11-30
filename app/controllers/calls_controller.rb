class CallsController < ApplicationController

  include CallsHelper

  def get_twilio_jwt
    render json: JSON.generate(CallsHelper.get_twilio_jwt)
  end

  def create
    room_name = SecureRandom.uuid

    @call = Call.create(sender: current_user, recipients: [User.find(params[:recipient])], room_name: room_name, twilio_sid: room_name + '_twilio') # TODO: un-hardcode data

    session[:call_id] = @call.id

    redirect_to "/start/#{room_name}"
  end

  def start
    @call = Call.find(session[:call_id])
    @recipient = @call.recipients.first
  end

  def join
    @call = Call.find(session[:call_id]) # TODO - is this correct logic?
  end

  def end_call
    @call = Call.find(session[:call_id])
    @recipient = @call.recipients.first

    @duration = 5 # TODO un-hardcode duration
    @price = @duration * 1.5
  end

  # def update
  #   @call = Call.new
  # end

end
