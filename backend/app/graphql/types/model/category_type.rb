module Types::Model
  class CategoryType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :user_id, ID, null: false
  end
end
