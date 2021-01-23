module Queries::Item
  class FetchItem < Queries::Generic::FetchQuery
    self.resource_class = Item
    type Types::Model::ItemType, null: false
  end
end
