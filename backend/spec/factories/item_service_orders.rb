FactoryBot.define do
  factory :item_service_order do
    association :service_order
    association :item

    quantity { Faker::Number.between(from: 1, to: 10) }
    purchase_price { 3.50 }
    sale_price { 5.00 }
  end
end
