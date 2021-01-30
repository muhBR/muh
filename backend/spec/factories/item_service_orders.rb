FactoryBot.define do
  factory :item_service_order do
    association :service_order
    association :item

    quantity { Faker::Number.between(from: 1, to: 10) }
  end
end
