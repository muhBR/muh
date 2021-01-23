module Mutations::Category
  class DeleteCategory < Mutations::Generic::DeleteMutation
    self.resource_class = Category
    type Types::Model::CategoryType
  end
end
