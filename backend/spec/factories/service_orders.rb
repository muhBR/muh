FactoryBot.define do
  factory :service_order do
    association :user
    association :customer

    name { Faker::Music.unique.band }
    status { ServiceOrder::STATUSES[0] }
  end
end
