
# TODO: seed random

def puts_para(str)
  puts "#{str}\n\n"
end

users = JSON.parse(File.read(File.join(__dir__, 'seed_data/users.json')), symbolize_names: true)[:results]

# user_images = JSON.parse(File.read(File.join(__dir__, 'seed_data/user_images.json')), symbolize_names: true)

puts_para "destroying all your stuff, buckle up!"

User.destroy_all

puts_para "creating new stuff"

20.times do |idx|
  u_data = users[idx]

  gender = u_data[:gender]

  names = []
  names << u_data[:name][:first].capitalize
  # names << Faker::Name.middle_name.capitalize if rand > 0.8
  names << u_data[:name][:last].capitalize

  name = names.join(' ')
  email = u_data[:email]

  user = User.new(
    name: name,
    email: email,
    password: Faker::Internet.password(12),
    interpreter: idx.odd?,
    language: 'Auslan',
    avatar: Rails.root.join("db/seed_data/images/#{u_data[:picture][:large].match(/[^\/]+$/).to_s}").open
  )

  user.last_seen = Time.now if idx < 10

  user.save!

  if user.interpreter?
    user.update!(bio: Faker::Lorem.sentence, gender: gender, certifications: "Naati level #{[2, 3].sample}")
  end
end

# test accounts must come last

test_interpreter = User.create!(name: 'Interpreter', email: 'test@interpreter.com', password: '123123', interpreter: true, last_seen: Time.now, bio: "fake bio", gender: 'female', language: 'Auslan', certifications: 'Naati level 2')

test_customer = User.create!(name: 'Customer', email: 'test@customer.com', password: '123123', language: "Auslan")

test_accounts = [test_interpreter, test_customer]

puts_para "created #{User.count} users, including #{User.where(interpreter: false).count} customer profiles and #{User.where(interpreter: true).count} interpreter profiles."
puts_para "your test accounts:\n#{test_accounts.map { |acc| "#{acc.email} | #{acc.password}" }.join("\n")}"
