FactoryBot.define do
  factory :business_idea do
    title { Faker::Book.title }
    description { "This is a test business idea." }
    country { "UK" }
    association :user  # Links this idea to a user
  end
end