FactoryBot.define do
  factory :customer do
    association :user

    name { Faker::Creature::Animal.unique.name }
    phone { Faker::Number.between(from: Customer::MIN_PHONE_VALUE, to: Customer::MAX_PHONE_VALUE) }
    email { Faker::Internet.unique.email }
  end
end
