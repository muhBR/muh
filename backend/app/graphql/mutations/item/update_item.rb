module Mutations::Item
  class UpdateItem < Mutations::Generic::UpdateMutation
    self.resource_class = Item

    argument :id, ID, required: true
    argument :category_id, ID, required: false
    argument :name, String, required: false
    argument :item_type, String, required: false
    argument :description, String, required: false
    argument :sale_price, Float, required: false
    argument :purchase_price, Float, required: false

    type Types::Model::ItemType
  end
end
