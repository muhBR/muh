module Mutations::Category
  class CreateCategory < Mutations::Generic::CreateMutation
    self.resource_class = Category

    argument :name, String, required: true

    type Types::Model::CategoryType
  end
end
