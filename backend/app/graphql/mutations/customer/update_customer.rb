module Mutations::Customer
  class UpdateCustomer < Mutations::Generic::UpdateMutation
    self.resource_class = Customer

    argument :id, ID, required: true
    argument :name, String, required: true
    argument :email, String, required: true
    argument :phone, GraphQL::Types::BigInt, required: true

    type Types::Model::CustomerType
  end
end
