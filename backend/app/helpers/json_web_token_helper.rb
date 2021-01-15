# frozen_string_literal: true

module JsonWebTokenHelper
  JWT_SECRET_KEY = ENV.fetch('JWT_SECRET_KEY')

  def authorize_request
    header = request.headers['Authorization']
    token = header.split.last if header
    # rubocop:disable Rails/HelperInstanceVariable
    @current_user = user_by_token(token)
  end

  def encode_user(user, exp = 1.day.from_now)
    payload = {}
    payload[:exp] = exp.to_i
    payload[:user_id] = user.id
    payload[:email] = user.email

    JWT.encode(payload, JWT_SECRET_KEY)
  end

  def user_by_token(token)
    decoded = decode_token(token)
    User.find_by(id: decoded[:user_id])
  rescue JWT::ExpiredSignature, JWT::DecodeError
    nil
  end

  def current_user
    @current_user
    # rubocop:enable Rails/HelperInstanceVariable
  end

  private

  def decode_token(token)
    decoded = JWT.decode(token, JWT_SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end
