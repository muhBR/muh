FactoryBot.define do
  factory :item do
    association :user
    association :category

    name { Faker::Beer.unique.name }
    item_type { Item::TYPES[0] }
    description { Faker::FunnyName.three_word_name }
    purchase_price { 1.25 }
    sale_price { 2.50 }
  end
end
