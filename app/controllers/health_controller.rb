class HealthController < ApplicationController
  def show
    # Basic health check
    render json: {
      status: "ok",
      timestamp: Time.current.iso8601,
      version: Rails.application.config.version || "1.0.0"
    }
  end

  def detailed
    # Detailed health check for monitoring
    checks = {
      database: database_check,
      email: email_check,
      storage: storage_check
    }

    all_healthy = checks.values.all? { |check| check[:status] == "ok" }

    render json: {
      status: all_healthy ? "ok" : "degraded",
      timestamp: Time.current.iso8601,
      checks: checks
    }, status: all_healthy ? :ok : :service_unavailable
  end

  private

  def database_check
    ActiveRecord::Base.connection.execute("SELECT 1")
    { status: "ok", message: "Database connection successful" }
  rescue => e
    { status: "error", message: e.message }
  end

  def email_check
    # Check if email configuration is present
    if ENV["SMTP_USERNAME"] && ENV["SMTP_PASSWORD"]
      { status: "ok", message: "Email configuration present" }
    else
      { status: "warning", message: "Email configuration not set" }
    end
  rescue => e
    { status: "error", message: e.message }
  end

  def storage_check
    # Check if storage directory is writable
    if File.writable?(Rails.root.join("storage"))
      { status: "ok", message: "Storage directory writable" }
    else
      { status: "error", message: "Storage directory not writable" }
    end
  rescue => e
    { status: "error", message: e.message }
  end
end
