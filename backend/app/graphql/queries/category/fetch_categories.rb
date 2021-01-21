module Queries::Category
  class FetchCategories < Queries::BaseQuery
    type [Types::Model::CategoryType], null: false

    def resolve
      Category.where(user: current_user)
    end
  end
end
