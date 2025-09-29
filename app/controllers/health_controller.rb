class HealthController < ApplicationController
  def show
    render json: { status: 'ok', timestamp: Time.current }
  end

  def detailed
    render json: {
      status: 'ok',
      timestamp: Time.current,
      database: database_status,
      cache: cache_status,
      version: Rails.version
    }
  end

  private

  def database_status
    ActiveRecord::Base.connection.active? ? 'connected' : 'disconnected'
  rescue
    'error'
  end

  def cache_status
    Rails.cache.write('health_check', 'ok', expires_in: 1.minute)
    Rails.cache.read('health_check') == 'ok' ? 'working' : 'error'
  rescue
    'error'
  end
end