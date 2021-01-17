module Mutations
  class CreateCategory < BaseMutation
    argument :name, String, required: true

    type Types::CategoryType

    def resolve(name: nil)
      Category.create!(
        name: name,
        user: context[:current_user]
      )
    end
  end
end
