module Mutations::User
  class CreateUser < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    type Types::Model::UserType

    def resolve(email: nil, password: nil)
      User.create!(
        email: email,
        password: password
      )
    end
  end
end
