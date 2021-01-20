module Queries::Category
  class FetchCategories < Queries::BaseQuery
    type [Types::Model::CategoryType], null: false

    def resolve
      Category.all
    end
  end
end
