require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot for better performance and memory savings (ignored by Rake tasks).
  config.eager_load = true

  # Full error reports are disabled.
  config.consider_all_requests_local = false

  # Turn on fragment caching in view templates.
  config.action_controller.perform_caching = true

  # Cache assets for far-future expiry since they are all digest stamped.
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.asset_host = "http://assets.example.com"

  # No Active Storage configuration needed

  # Assume all access to the app is happening through a SSL-terminating reverse proxy.
  config.assume_ssl = true

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = false # Railway handles SSL termination

  # Skip http-to-https redirect for the default health check endpoint.
  # config.ssl_options = { redirect: { exclude: ->(request) { request.path == "/up" } } }

  # Log to STDOUT with the current request id as a default log tag.
  config.log_tags = [ :request_id ]
  config.logger   = ActiveSupport::TaggedLogging.logger(STDOUT)

  # Change to "debug" to log everything (including potentially personally-identifiable information!)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Prevent health checks from clogging up the logs.
  config.silence_healthcheck_path = "/up"

  # Don't log any deprecations.
  config.active_support.report_deprecations = false

  # Use memory cache store (no database needed)
  config.cache_store = :memory_store

  # Ensure static files are served in production
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present? || ENV["RAILS_SERVE_STATIC_ASSETS"].present?

  # --- Host allowlist for Railway & your domain ---
  config.hosts << "web-production-07b1.up.railway.app"
  config.hosts << /.*\.up\.railway\.app/
  config.hosts << /.*\.railway\.app/

  # Your domain (match apex and any subdomain like www)
  config.hosts << /\A(?:.*\.)?columbinetherapy\.com\z/


  # (Optional) env-driven, so you don't hardcode
  if ENV["RAILS_ALLOWED_HOSTS"].present?
    ENV["RAILS_ALLOWED_HOSTS"].split(",").each do |h|
      h = h.strip
      config.hosts << (h.start_with?("/") && h.end_with?("/") ? Regexp.new(h[1..-2]) : h)
    end
  end

  # Use async adapter for Active Job (no database needed)
  config.active_job.queue_adapter = :async

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Set host to be used by links generated in mailer templates.
  config.action_mailer.default_url_options = { host: ENV.fetch("APP_HOST", "localhost:3000") } # e.g. myapp.up.railway.app

  # Mail delivery (SMTP via env vars)
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:        ENV.fetch("SMTP_ADDRESS", "smtp.gmail.com"),      # e.g. "smtp.sendgrid.net"
    port:           ENV.fetch("SMTP_PORT", 587).to_i,
    user_name:      ENV.fetch("SMTP_USERNAME", "dummy"),
    password:       ENV.fetch("SMTP_PASSWORD", "dummy"),
    authentication: :plain,
    enable_starttls_auto: true
  }

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true


  # Skip DNS rebinding protection for the default health check endpoint.
  config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
end
