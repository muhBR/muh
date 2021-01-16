# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include JsonWebTokenHelper

  skip_before_action :verify_authenticity_token
end
