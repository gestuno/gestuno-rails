module ChargesHelper

  class << self

    def aud_cents_cost_of(call)
      raw = (call.duration * 1.5).to_i
      min = 100

      raw > min ? raw : min
    end

    def aud_cents_earnings_from(call)
      raw = (call.duration * 1.25).to_i
      min = 75

      raw > min ? raw : min
    end

  end
end
