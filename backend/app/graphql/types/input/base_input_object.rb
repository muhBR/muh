module Types::Input
  class BaseInputObject < GraphQL::Schema::InputObject
    argument_class GraphQL::Schema::Argument
  end
end
