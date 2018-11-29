module CallsHelper
  AccessToken = Twilio::JWT::AccessToken
  VideoGrant = AccessToken::VideoGrant

  def self.get_twilio_jwt
    identity = "#{Faker::Name.name}@#{Time.new.to_f.to_s.gsub(/\./, '')}"

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

  AccessToken = Twilio::JWT::AccessToken
  VideoGrant = AccessToken::VideoGrant
end
