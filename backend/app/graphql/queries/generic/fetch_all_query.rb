module Queries::Generic
  class FetchAllQuery < Queries::BaseQuery
    class_attribute :resource_class

    def resolve
      resource_class.where(user: current_user)
    end
  end
end
