def puts_para(str)
  puts "#{str}\n\n"
end

users = JSON.parse(File.read(File.join(__dir__, 'seed_data/users.json')), symbolize_names: true)[:results]

# debugger

puts_para "destroying all your stuff, buckle up!"

User.destroy_all

puts_para "creating new stuff"

20.times do |idx|
  user = users[idx]

  gender = user[:gender]

  names = []
  names << user[:name][:first].capitalize
  names << Faker::Name.middle_name.capitalize if rand > 0.8
  names << user[:name][:last].capitalize

  name = names.join(' ')

  user = User.new(name: name, email: user[:email], password: Faker::Internet.password(12))
  user.interpreter = idx < 10
  user.last_seen = Time.now if idx.even?

  user.save!

  if user.interpreter?
    user.profile.update!(bio: Faker::Lorem.sentence, gender: gender, language: 'Auslan', certifications: "Naati level #{[2, 3].sample}")
  else
    user.profile.update!(language: 'Auslan')
  end
end

# test accounts must come last

test_interpreter = User.create!(name: 'Interpreter', email: 'test@interpreter.com', password: '123123', interpreter: true, last_seen: Time.now)
test_interpreter.profile.update!(bio: "fake bio", gender: 'female', language: 'Auslan', certifications: 'Naati level 2')

test_customer = User.create!(name: 'Customer', email: 'test@customer.com', password: '123123')
test_customer.profile.update!(language: "Auslan")

test_accounts = [test_interpreter, test_customer]

puts_para "created #{User.count} users, #{CustomerProfile.count} customer profiles, #{InterpreterProfile.count} interpreter profiles."
puts_para "your test accounts:\n#{test_accounts.map { |acc| "#{acc.email} | #{acc.password}" }.join("\n")}"
