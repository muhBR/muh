module Mutations
  class CreateCategory < BaseMutation
    argument :name, String, required: true

    type Types::CategoryType

    def resolve(name: nil)
      Category.create!(
        name: name,
        user: context[:current_user]
      )
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
