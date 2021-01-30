module Types::Model
  class ServiceOrderType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :status, String, null: false
    field :extra_information, String, null: false
    field :accomplishment_date, String, null: false
    field :delivery_date, String, null: false
    field :discount, Float, null: false

    field :customer, CustomerType, null: false
    field :item_service_orders, [ItemServiceOrderType], null: false
  end
end
