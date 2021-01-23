module Types
  class QueryType < Types::Model::BaseObject
    field :fetch_categories, resolver: Queries::Category::FetchCategories
    field :fetch_category, resolver: Queries::Category::FetchCategory

    field :fetch_items, resolver: Queries::Item::FetchItems
    field :fetch_item, resolver: Queries::Item::FetchItem

    field :fetch_customers, resolver: Queries::Customer::FetchCustomers
    field :fetch_customer, resolver: Queries::Customer::FetchCustomer
  end
end
