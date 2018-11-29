class CallsController < ApplicationController

  include CallsHelper

  # def get_twilio_jwt
  #   render json: JSON.generate(CallsHelper.get_twilio_jwt)
  # end

  def create
    jwt = CallsHelper.get_twilio_jwt
    room_name = SecureRandom.uuid

    # TODO fdfkjsghkjghsjkd

    @call = Call.create(sender: User.first, recipients: [User.second], room_name: room_name, twilio_sid: 'hello twilio')

  end

  def update
    @call = Call.new
  end

  def show

    Call.create(sender: User.first, recipients: [User.second], room_name: '💩poop', twilio_sid: 'hello twilioaaa')

    @call = Call.new()

    raise

  end

end
