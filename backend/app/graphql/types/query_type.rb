module Types
  class QueryType < Types::BaseObject
    field :fetch_categories, resolver: Queries::FetchCategories
    field :fetch_category, resolver: Queries::FetchCategory
    field :fetch_items, resolver: Queries::FetchItems
    field :fetch_item, resolver: Queries::FetchItem
  end
end
