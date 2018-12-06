module Utils
  class << self

    # def email_to_name(email)
    #   email.gsub(/@.+/, '').split(/[-_.]/).map { |word| word.capitalize } .join(' ')
    # end

    def name_to_initials(name)
      name.split(/\s+/).map { |word| word[0].upcase } .join('')[0..2]
    end

    def str_to_bg_and_fg_color(str)
      digest = Digest::SHA256.hexdigest(str).to_i(16)

      color = '#' + Random.new(digest).rand(0..16777215).to_s(16).rjust(6, '0')

      r = color[1..2].to_i(16)
      g = color[3..4].to_i(16)
      b = color[5..6].to_i(16)

      lum = (0.299 * r + 0.587 * g + 0.114 * b) / 255

      fg = lum > 0.6 ? '#333' : '#eee'

      {
        bg: color,
        fg: fg
      }
    end

    def format_aud_cents(price)
      ActionController::Base.helpers.number_to_currency(price / 100.0, unit: "AU$")
    end

    def format_hhmmss(seconds)
      h = (seconds / 60 / 60).floor
      m = ((seconds / 60) - (h * 60)).floor
      s = (seconds - (m * 60) - (h * 60 * 60)).floor

      all = h.positive? ? [h, m, s] : [m, s]

      all.map { |n| n.to_s.rjust(2, '0') } .join(':')
    end

  end
end
