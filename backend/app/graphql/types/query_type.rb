module Types
  class QueryType < Types::BaseObject
    field :fetch_categories, resolver: Queries::FetchCategories
    field :fetch_category, resolver: Queries::FetchCategory
  end
end
