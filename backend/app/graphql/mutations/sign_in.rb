module Mutations
  class SignIn < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    type Types::UserType

    def resolve(email: nil, password: nil)
      user = User.find_by(email: email)
      raise UnauthorizedException, 'Unauthorized :(' unless user&.authenticate(password)

      user
    end
  end
end
