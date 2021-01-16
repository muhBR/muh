module Queries
  class FetchCategories < Queries::BaseQuery
    type [Types::CategoryType], null: false

    def resolve
      Category.all
    end
  end
end
