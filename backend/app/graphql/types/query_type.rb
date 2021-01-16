module Types
  class QueryType < Types::BaseObject
    field :fetch_categories, resolver: Queries::FetchCategories
  end
end
