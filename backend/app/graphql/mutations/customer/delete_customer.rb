module Mutations::Customer
  class DeleteCustomer < Mutations::Generic::DeleteMutation
    self.resource_class = Customer
    type Types::Model::CustomerType
  end
end
