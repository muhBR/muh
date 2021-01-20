module Mutations::Category
  class CreateCategory < Mutations::BaseMutation
    argument :name, String, required: true

    type Types::Model::CategoryType

    def resolve(name: nil)
      Category.create!(
        name: name,
        user: context[:current_user]
      )
    end
  end
end
