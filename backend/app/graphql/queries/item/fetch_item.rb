module Queries::Item
  class FetchItem < Queries::BaseQuery
    argument :id, ID, required: true

    type Types::Model::ItemType, null: false

    def resolve(id:)
      Item.find(id)
    end
  end
end
