module Types::Model
  class ItemServiceOrderType < BaseObject
    field :id, ID, null: false
    field :item_id, ID, null: false
    field :service_order_id, ID, null: false
    field :purchase_price, Float, null: false
    field :sale_price, Float, null: false
    field :quantity, Int, null: false
  end
end
