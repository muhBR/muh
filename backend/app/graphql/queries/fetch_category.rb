module Queries
  class FetchCategory < Queries::BaseQuery
    argument :id, ID, required: true

    type Types::CategoryType, null: false

    def resolve(id:)
      Category.find(id)
    end
  end
end
