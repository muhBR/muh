module Queries::Customer
  class FetchCustomers < Queries::Generic::FetchAllQuery
    self.resource_class = Customer
    type [Types::Model::CustomerType], null: false
  end
end
