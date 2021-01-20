module Mutations::Item
  class CreateItem < Mutations::BaseMutation
    argument :name, String, required: true
    argument :item_type, String, required: true
    argument :description, String, required: true
    argument :sale_price, Float, required: true
    argument :purchase_price, Float, required: true
    argument :category_id, ID, required: true

    type Types::Model::ItemType

    def resolve(params)
      item = Item.new(params)
      item.user = context[:current_user]
      item.save!
      item
    end
  end
end
