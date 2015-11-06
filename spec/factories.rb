FactoryGirl.define do
  factory :user do
    name                  "forbiddenuser"
    email                 "forbiddenuser@teste.com"
    login                 "forbiddenuser"
    password              "forbidden"
    password_confirmation "forbidden"
  end

  factory :team do
    name                  "SIOHATECPROGGERS"
    email                 "SIOHINHA@siohinha.com"
    description           "balblalbalbalbla"
  end

  factory :requirement do
    code                  "US00002"
    description           "Uma estoria muito loka"
    type                  "UserStory"
    priority              "high"
  end
end
