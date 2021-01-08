# frozen_string_literal: true

module JsonWebTokenHelper
  SECRET_KEY = 'super_secret_key'

  def encode_user(user, exp = 1.day.from_now)
    payload = {}
    payload[:exp] = exp.to_i
    payload[:user_id] = user.id
    payload[:email] = user.email

    JWT.encode(payload, SECRET_KEY)
  end

  def user_by_token(token)
    decoded = decode_token(token)
    User.find_by(id: decoded[:user_id])
  rescue JWT::ExpiredSignature, JWT::DecodeError
    nil
  end

  private

  def decode_token(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end
