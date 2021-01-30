module Types::Input
  class ItemServiceOrderInput < BaseInputObject
    graphql_name 'ITEM_SERVICE_ORDER'

    argument :item_id, ID, required: true
    argument :quantity, GraphQL::Types::BigInt, required: true
  end
end
