module Mutations::Generic
  class CreateMutation < Mutations::BaseMutation
    class_attribute :resource_class

    def resolve(params)
      resource = resource_class.new(params)
      resource.user = context[:current_user]
      resource.save!
      resource
    end
  end
end
