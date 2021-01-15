module Types
  class CategoryType < Types::BaseObject
    include JsonWebTokenHelper

    field :id, ID, null: false
    field :name, String, null: false
    field :user_id, ID, null: false
  end
end
