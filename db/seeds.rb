def puts_para(str)
  puts "#{str}\n\n"
end

puts_para "destroying all your stuff, buckle up!"

User.destroy_all

puts_para "creating new stuff"

20.times do |idx|
  user = User.new(email: Faker::Internet.email(nil, '.'), password: Faker::Internet.password(12))
  user.interpreter = idx < 10
  user.last_seen = Time.now if idx.even?

  user.save!
end

User.all.each do |user|
  if user.interpreter?
    user.profile.update!(bio: Faker::Lorem.sentence, gender: Faker::Gender.binary_type, language: 'Auslan', certifications: "Naati level #{[2, 3].sample}")
  else
    user.profile.update!(language: 'Auslan')
  end
end

# test accounts must come last

test_interpreter = User.create!(name: 'interpreter', email: 'test@interpreter.com', password: '123123', interpreter: true, last_seen: Time.now)
test_interpreter.profile.update!(bio: "fake bio", gender: 'female', language: 'Auslan', certifications: 'Naati level 2')

test_customer = User.create!(name: 'customer', email: 'test@customer.com', password: '123123')
test_customer.profile.update!(language: "Auslan")

test_accounts = [test_interpreter, test_customer]

puts_para "created #{User.count} users, #{CustomerProfile.count} customer profiles, #{InterpreterProfile.count} interpreter profiles."
puts_para "your test accounts:\n#{test_accounts.map { |acc| "#{acc.email} | #{acc.password}" }.join("\n")}"
