module Queries::Category
  class FetchCategory < Queries::BaseQuery
    argument :id, ID, required: true

    type Types::Model::CategoryType, null: false

    def resolve(id:)
      Category.find(id)
    end
  end
end
