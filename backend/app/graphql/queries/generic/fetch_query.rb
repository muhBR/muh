module Queries::Generic
  class FetchQuery < Queries::BaseQuery
    class_attribute :resource_class

    argument :id, ID, required: true

    def resolve(id:)
      resource_class.find_by!(id: id, user: current_user)
    end
  end
end
