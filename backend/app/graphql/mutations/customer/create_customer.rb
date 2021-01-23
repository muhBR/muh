module Mutations::Customer
  class CreateCustomer < Mutations::Generic::CreateMutation
    self.resource_class = Customer

    argument :name, String, required: true
    argument :email, String, required: true
    argument :phone, GraphQL::Types::BigInt, required: true

    type Types::Model::CustomerType
  end
end
