FactoryBot.define do
  factory :item do
    association :user
    association :category

    name { Faker::Beer.unique.name }
    item_type { Item::TYPES[0] }
    description { Faker::FunnyName.three_word_name }
    purchase_price { Faker::Number.decimal_part(digits: 2) }
    sale_price { Faker::Number.decimal_part(digits: 2) }
  end
end
