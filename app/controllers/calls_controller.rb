class CallsController < ApplicationController

  include CallsHelper

  def get_twilio_jwt
    render json: JSON.generate(CallsHelper.get_twilio_jwt(current_user))
  end

  def create
    room_name = SecureRandom.uuid

    @call = Call.create(sender: current_user, recipients: [User.find(params[:recipient])], room_name: room_name) # TODO: un-hardcode data

    session[:call_id] = @call.id

    redirect_to "/start"
  end

  def start # TODO - handle call already finished
    @call = Call.find(session[:call_id])
    @interlocutor = @call.recipients.first
  end

  # def update # TODO - add recipient to call, then redirect to join
  # end

  def attach_twilio_sid
    headers
  end

  def join # TODO - handle call already finished
    @call = Call.find_by(room_name: params[:room])
    session[:call_id] = @call.id
    @interlocutor = @call.sender
  end

  def end_call
    @call = Call.find(session[:call_id])
    @interlocutor = @call.recipients.first
    # TODO - commenting this out to test STRIPE
    # @duration = 5 # TODO un-hardcode duration
    # @price = @duration * 1.5
  end

  # def update
  #   @call = Call.new
  # end

end
