module Types
  class ItemType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, ID, null: false
    field :name, String, null: false
    field :item_type, String, null: false
    field :description, String, null: false
    field :sale_price, Float, null: false
    field :purchase_price, Float, null: false

    field :category, Types::CategoryType, null: true
  end
end
