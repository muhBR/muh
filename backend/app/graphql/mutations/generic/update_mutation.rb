module Mutations::Generic
  class UpdateMutation < Mutations::BaseMutation
    class_attribute :resource_class

    def resolve(params)
      resource = resource_class.find_by!(id: params[:id], user: current_user)
      resource.update!(params)
      resource
    end
  end
end
