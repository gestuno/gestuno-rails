class CallsController < ApplicationController

  include CallsHelper

  def get_twilio_jwt
    render json: JSON.generate(CallsHelper.get_twilio_jwt)
  end
end
