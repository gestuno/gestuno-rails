AccessToken = Twilio::JWT::AccessToken
VideoGrant = AccessToken::VideoGrant

module CallsHelper
  def self.get_twilio_jwt
    identity = "#{Faker::Name.name}@#{Time.new.to_f.to_s.gsub(/\./, '')}" # TODO: use actual user email

    token = AccessToken.new(
      ENV['TWILIO_ACCOUNT_SID'],
      ENV['TWILIO_API_KEY'],
      ENV['TWILIO_API_SECRET']
    )

    token.identity = identity

    grant = VideoGrant.new
    token.add_grant(grant)

    {
      identity: identity,
      token: token.to_jwt
    }
  end

  def self.get_twilio_room_info(room_sid)
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    @client.video.rooms(room_sid).fetch
  end
end
