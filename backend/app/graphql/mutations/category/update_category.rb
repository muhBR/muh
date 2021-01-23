module Mutations::Category
  class UpdateCategory < Mutations::Generic::UpdateMutation
    self.resource_class = Category

    argument :id, ID, required: true
    argument :name, String, required: true

    type Types::Model::CategoryType
  end
end
