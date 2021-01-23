module Queries::Item
  class FetchItems < Queries::Generic::FetchAllQuery
    self.resource_class = Item
    type [Types::Model::ItemType], null: false
  end
end
