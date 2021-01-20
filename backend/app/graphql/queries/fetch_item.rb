module Queries
  class FetchItem < Queries::BaseQuery
    argument :id, ID, required: true

    type Types::ItemType, null: false

    def resolve(id:)
      Item.find(id)
    end
  end
end
