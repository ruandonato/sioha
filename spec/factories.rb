FactoryGirl.define do
#instantiate a user with mandatory params to create a user
  factory :user do
    name                  "forbiddenuser"
    email                 "forbiddenuser@teste.com"
    login                 "forbiddenuser"
    password              "forbidden"
    password_confirmation "forbidden"
  end
#instantiate a team with mandatory params to create team
  factory :team do
    name                  "SIOHATECPROGGERS"
    email                 "SIOHINHA@siohinha.com"
    description           "balblalbalbalbla"
  end
#instantiate a user story with mandatory params to create a story
  factory :requirement do
    code                  "US00002"
    description           "Uma estoria muito loka"
    type                  "UserStory"
    priority              "high"
  end
end
