FactoryBot.define do
  factory :idea do
    due_date { Faker::Date.in_date_period }
    priority { 0 }
    action_point { "Idea to implement" }
    status { 0 }
    added_to_business_plan { true }
    association :user  # Links this idea to a user
  end
end