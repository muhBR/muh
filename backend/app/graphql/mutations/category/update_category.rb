module Mutations::Category
  class UpdateCategory < Mutations::BaseMutation
    argument :id, ID, required: true

    argument :name, String, required: true

    type Types::Model::CategoryType

    def resolve(id:, name:)
      category = Category.find(id)
      category.update!(name: name)
      category
    end
  end
end
