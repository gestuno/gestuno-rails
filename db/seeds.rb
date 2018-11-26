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

bojack = User.create!(email: 'bojack@horse.man', password: '123123')
ozzy = User.create!(email: 'ozzy@the.osbournes', password: 'drowssap')
alice = User.create!(email: 'alice@wonder.land', password: 'h4xx0r')

profile = InterpreterProfile.create!(bio: "BoJack Horseman is an American adult animated comedy-drama series created by Raphael Bob-Waksberg. The series stars Will Arnett as the title character, with a supporting cast including Amy Sedaris, Alison Brie, Paul F. Tompkins, and Aaron Paul. The series' first season premiered on August 22, 2014, on Netflix, with a Christmas special premiering on December 19. The show is designed by the cartoonist Lisa Hanawalt, who had previously worked with Bob-Waksberg on the webcomic Tip Me Over, Pour Me Out.[7]", gender: 'male', online: false)

bojack.interpreter_profile = profile

call = Call.create!(interpreter: bojack, customer: alice)

puts "created #{User.count} users, #{InterpreterProfile.count} interpreter profiles, and #{Call.count} calls."

