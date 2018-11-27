# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'destroying all your stuff, buckle up!'

Call.destroy_all
InterpreterProfile.destroy_all
User.destroy_all

puts 'creating new stuff'

20.times do
  User.create!(email: Faker::Internet.email, password: Faker::Internet.password(6, 6))
end

10.times do |idx|
  InterpreterProfile.create!(bio: Faker::Lorem.sentence, gender: Faker::Gender.binary_type, online: false, user: User.limit(1).offset(idx)[0])
end


# test accounts must come last

ti = User.create!(email: 'test@interpreter.com', password: '123123')
InterpreterProfile.create!(bio: "fake bio", gender: 'female', online: false, user: ti)

tc = User.create!(email: 'test@customer.com', password: '123123')


# call = Call.create!(interpreter: bojack, customer: alice)

puts "created #{User.count} users, #{InterpreterProfile.count} interpreter profiles, and #{Call.count} calls."
puts "your test accounts:\n#{[ti, tc].map { |acc| "#{acc.email}|#{acc.password}" }.join("\n")}"
