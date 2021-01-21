module Queries::Item
  class FetchItems < Queries::BaseQuery
    type [Types::Model::ItemType], null: false

    def resolve
      Item.where(user: current_user)
    end
  end
end
