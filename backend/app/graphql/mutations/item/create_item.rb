module Mutations::Item
  class CreateItem < Mutations::Generic::CreateMutation
    self.resource_class = Item

    argument :name, String, required: true
    argument :item_type, String, required: true
    argument :description, String, required: true
    argument :sale_price, Float, required: true
    argument :purchase_price, Float, required: true
    argument :category_id, ID, required: true

    type Types::Model::ItemType
  end
end
