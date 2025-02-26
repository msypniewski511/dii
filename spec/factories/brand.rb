FactoryBot.define do
  factory :brand do
    business_name { Faker::Company.name }
    website_domain { Faker::Internet.domain_name }
    association :user  # Links this idea to a user
  end
end