module Mutations::Item
  class DeleteItem < Mutations::Generic::DeleteMutation
    self.resource_class = Item
    type Types::Model::ItemType
  end
end
