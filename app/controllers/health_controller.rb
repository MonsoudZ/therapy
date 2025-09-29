class HealthController < ApplicationController
  # Skip CSRF protection for health checks
  skip_before_action :verify_authenticity_token
  
  def show
    # Basic health check - just return 200 OK
    # Don't check database for basic health check to avoid Railway failures
    render plain: "OK", status: :ok
  end
  
  def detailed
    # More detailed health check
    checks = {
      database: database_healthy?,
      cache: cache_healthy?,
      timestamp: Time.current.iso8601
    }
    
    if checks[:database] && checks[:cache]
      render json: { status: "healthy", checks: checks }, status: :ok
    else
      render json: { status: "unhealthy", checks: checks }, status: :service_unavailable
    end
  end
  
  private
  
  def database_healthy?
    # Check if database connection is available
    ActiveRecord::Base.connection.execute("SELECT 1")
    true
  rescue => e
    Rails.logger.error "Database health check failed: #{e.message}"
    false
  end
  
  def cache_healthy?
    Rails.cache.write("health_check", "test", expires_in: 1.second)
    Rails.cache.read("health_check") == "test"
  rescue => e
    Rails.logger.error "Cache health check failed: #{e.message}"
    false
  end
end