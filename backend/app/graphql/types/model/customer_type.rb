module Types::Model
  class CustomerType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :phone, GraphQL::Types::BigInt, null: false
  end
end
