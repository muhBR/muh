FactoryBot.define do
  factory :category do
    name { Faker::Color.unique.color_name }
    association :user
  end
end
