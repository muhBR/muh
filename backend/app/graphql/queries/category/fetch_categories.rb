module Queries::Category
  class FetchCategories < Queries::Generic::FetchAllQuery
    self.resource_class = Category
    type [Types::Model::CategoryType], null: false
  end
end
