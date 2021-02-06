FactoryBot.define do
  factory :category do
    name { Faker::Music.unique.band }
    association :user
  end
end
