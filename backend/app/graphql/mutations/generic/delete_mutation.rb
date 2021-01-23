module Mutations::Generic
  class DeleteMutation < Mutations::BaseMutation
    class_attribute :resource_class

    argument :id, ID, required: true

    def resolve(id: nil)
      resource = resource_class.find_by!(id: id, user: current_user)
      resource.destroy!
      resource
    end
  end
end
