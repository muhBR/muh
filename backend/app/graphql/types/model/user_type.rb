module Types::Model
  class UserType < BaseObject
    include JsonWebTokenHelper

    field :id, ID, null: false
    field :email, String, null: false
    field :token, String, null: false

    def token
      encode_user object
    end
  end
end
