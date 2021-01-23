module Queries::Customer
  class FetchCustomer < Queries::Generic::FetchQuery
    self.resource_class = Customer
    type Types::Model::CustomerType, null: false
  end
end
