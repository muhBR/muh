module Queries::Category
  class FetchCategory < Queries::Generic::FetchQuery
    self.resource_class = Category
    type Types::Model::CategoryType, null: false
  end
end
