module Queries::Item
  class FetchItems < Queries::BaseQuery
    type [Types::Model::ItemType], null: false

    def resolve
      Item.all
    end
  end
end
