# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include JsonWebTokenHelper

  skip_before_action :verify_authenticity_token

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from UnauthorizedException, with: :render_unauthorized

  def render_not_found(exception)
    render json: { error_message: exception.message }, status: :not_found
  end

  def render_unprocessable_entity(exception)
    render json: { error_message: exception.message }, status: :unprocessable_entity
  end

  def render_unauthorized(message = 'Unauthorized :(')
    render json: { error_message: message }, status: :unauthorized
  end
end
