module Mutations::Item
  class DeleteItem < Mutations::BaseMutation
    argument :id, ID, required: true
    type Types::Model::ItemType

    def resolve(id: nil)
      item = Item.find_by!(id: id, user: current_user)
      item.destroy!
      item
    end
  end
end
