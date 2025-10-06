class ErrorsController < ApplicationController
  layout "application"

  def not_found
    render :not_found, status: :not_found
  end

  def unprocessable
    render :unprocessable, status: :unprocessable_entity
  end

  def internal_error
    render :internal_error, status: :internal_server_error
  end
end
