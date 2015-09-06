# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

99.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "teste123"
  User.create(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

80.times do |b|
  user = User.find(b+1)
  name = Faker::Company.name
  description = Faker::Lorem.sentence(3, true, 4)
  Team.create(user: user,
              description: description,
              name: name)
end