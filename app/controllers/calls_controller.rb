class CallsController < ApplicationController

  include CallsHelper
  include ChargesHelper

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
    @current_user = current_user
    @interlocutor = @call.recipients.first
  end

  # def update # TODO - add recipient to call, then redirect to join
  # end

  def attach_twilio_sid
    @call = Call.find(params[:call_id])
    @call.twilio_sid = headers[:twilio_sid]
  end

  def join # TODO - handle call already finished
    @current_user = current_user
    @call = Call.find_by(room_name: params[:room])
    @call.start_time = Time.now
    @call.save
    session[:call_id] = @call.id
    @interlocutor = @call.sender
  end


  def end_call
    @call = Call.find(session[:call_id])

    @call.end_time = Time.now # TODO: get duration from Twilio instead
    @call.save

    @current_user = current_user
    @interlocutor = @current_user.customer? ? @call.recipients.first : @call.sender

    if @call.duration
      @duration = @call.duration # TODO check conversion of duration (seconds?)

      if current_user.customer?
        @price = ChargesHelper.aud_cents_cost_of(@call)
        # redirect_to charge_path
      else
        @earnings = ChargesHelper.aud_cents_earnings_from(@call)
        # redirect_to earnings_path
      end

      # @earnings = ChargesHelper.aud_cents_earnings_from(@call)

      # redirect_to charge_path
    else
      redirect_to interpreters_path
    end
  end


  # def update
  #   @call = Call.new
  # end

end
