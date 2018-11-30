module Utils
  def self.email_to_name(email)
    email.gsub(/@.+/, '').split(/[-_.]/).map { |word| word.capitalize } .join(' ')
  end
end
