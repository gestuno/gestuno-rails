
# TODO: seed random

def puts_para(str)
  puts "#{str}\n\n"
end

def gen_fake_review(props)
  stars = props[:base_stars] + rand(1..(5 - props[:base_stars]))

  Review.create!(interpreter: props[:interpreter], reviewer: props[:reviewer], rating: stars)
end

users = JSON.parse(File.read(File.join(__dir__, 'seed_data/users.json')), symbolize_names: true)[:results]

puts_para "destroying all your stuff, buckle up!"

User.destroy_all

puts_para "creating new stuff"

20.times do |idx|
  u_data = users[idx]

  gender = u_data[:gender]

  name = "#{u_data[:name][:first].capitalize} #{u_data[:name][:last].capitalize}"

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

    num_of_reviewers = rand(0..10)
    base_stars = rand(0..3)

    num_of_reviewers.times do
      reviewer = User.all_customers.sample
      gen_fake_review(interpreter: user, reviewer: reviewer, base_stars: base_stars)
    end

  end
end

# test accounts must come last

test_interpreter = User.create!(name: 'Alan Watts', email: 'test@interpreter.com', password: '123123', interpreter: true, last_seen: Time.now, bio:  Faker::Lorem.sentence, gender: 'male', language: 'Auslan', certifications: 'Naati level 2')

test_customer = User.create!(name: 'Alice Glass', email: 'test@customer.com', password: '123123', language: 'Auslan')

test_accounts = [test_interpreter, test_customer]

puts_para "created #{User.count} users, including #{User.where(interpreter: false).count} customer profiles and #{User.where(interpreter: true).count} interpreter profiles."
puts_para "your test accounts:\n#{test_accounts.map { |acc| "#{acc.email} | #{acc.password}" }.join("\n")}"
