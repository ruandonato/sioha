# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


  REQUIREMENT_TYPES_FOR_SCRUM = ["UserStory", "Feature"]
  REQUIREMENT_TYPES_FOR_SAFE = ["UserStory", "Feature", "InvestimentTheme"]
  PRIORITY_TYPES = ["high", "medium", "low"]


99.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "teste123"
  User.create(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

methodology = "SAFe"

80.times do |b|
  user = User.find(b+1)
  name = Faker::Company.name
  if methodology == "SAFe"
    methodology = "Scrum"
  else
    methodology = "SAFe"
  end

  description = Faker::Lorem.sentence(3, true, 4)
  t = Team.create(user: user,
              description: description,
              methodology: methodology,
              public_to_members: true,
              name: name)

  30.times do |j|
    aux = REQUIREMENT_TYPES_FOR_SAFE.sample
    if aux == "UserStory"
      req = UserStory.new
      req.author = t.user
      req.priority = PRIORITY_TYPES.sample
      req.team = t
      req.description = Faker::Lorem.sentence(3, true, 4)
      req.code = "US00"+j.to_s
      if req.save
        puts "New Requirement Created"
      else
        puts "Non saved!"
      end
    elsif aux == "Feature"
      req = Feature.new
      req.author = t.user
      req.priority = PRIORITY_TYPES.sample
      req.team = t
      req.code = "FT00"+j.to_s
      req.description = Faker::Lorem.sentence(3, true, 4)
      if req.save
        puts "New Requirement Created"
      else
        puts "Non saved!"
      end

    elsif aux == "InvestimentTheme"
      req = InvestimentTheme.new
      req.author = t.user
      req.priority = PRIORITY_TYPES.sample
      req.team = t
      req.code = "IT00"+j.to_s
      req.description = Faker::Lorem.sentence(3, true, 4)
      if req.save
        puts "New Requirement Created"
      else
        puts "Non saved!"
      end
    end
  end
end
