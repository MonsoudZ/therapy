# config/environments/production.rb
require "active_support/core_ext/integer/time"

Rails.application.configure do
  # --- Boot/Reload ---
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false

  # --- Caching / Static Assets ---
  config.action_controller.perform_caching = true
  config.cache_store = :memory_store

  # Serve static files in production when Railway sets ENV
  config.public_file_server.enabled =
    ENV["RAILS_SERVE_STATIC_FILES"].present? || ENV["RAILS_SERVE_STATIC_ASSETS"].present?

  # Far-future caching for digested assets
  config.public_file_server.headers = {
    "cache-control" => "public, max-age=#{1.year.to_i}"
  }

  # Optional: asset host if you ever put assets behind a CDN
  # config.asset_host = ENV["ASSET_HOST"] if ENV["ASSET_HOST"].present?

  # --- SSL / Proxy ---
  # We are behind Railway's SSL-terminating proxy
  config.assume_ssl = true
  config.force_ssl  = true

  # Let HTTP healthcheck hit /up without redirect loop
  config.ssl_options = {
    redirect: { exclude: ->(req) { req.path == "/up" } }
  }

  # --- Logging ---
  config.log_tags = [ :request_id ]
  config.logger   = ActiveSupport::TaggedLogging.logger(STDOUT)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.silence_healthcheck_path = "/up"
  config.active_support.report_deprecations = false

  # --- Hosts / DNS Rebinding ---
  # Railway service host(s)
  config.hosts << "web-production-07b1.up.railway.app"
  config.hosts << /.*\.up\.railway\.app/
  config.hosts << /.*\.railway\.app/

  # Your domain (apex and subdomains like www)
  config.hosts << /\A(?:.*\.)?columbinetherapy\.com\z/

  # Optional: allow list via ENV (comma-separated: e.g. "foo.com,/.*\.bar\.com/")
  if ENV["RAILS_ALLOWED_HOSTS"].present?
    ENV["RAILS_ALLOWED_HOSTS"].split(",").each do |h|
      h = h.strip
      config.hosts << (h.start_with?("/") && h.end_with?("/") ? Regexp.new(h[1..-2]) : h)
    end
  end

  # Skip host auth on healthcheck
  config.host_authorization = { exclude: ->(req) { req.path == "/up" } }

  # --- Jobs ---
  config.active_job.queue_adapter = :async

  # --- Mailer ---
  # Set the host used in generated URLs (emails, etc.)
  app_host = ENV.fetch("APP_HOST", "www.columbinetherapy.com")
  config.action_mailer.default_url_options = { host: app_host, protocol: "https" }

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              ENV.fetch("SMTP_ADDRESS", "smtp.gmail.com"),
    port:                 Integer(ENV.fetch("SMTP_PORT", "587")),
    user_name:            ENV.fetch("SMTP_USERNAME", "dummy"),
    password:             ENV.fetch("SMTP_PASSWORD", "dummy"),
    authentication:       :plain,
    enable_starttls_auto: true
  }

  # --- I18n ---
  config.i18n.fallbacks = true

  # --- OPTIONAL: Canonical redirect (301 everything to CANONICAL_HOST) ---
  # Set ENV CANONICAL_HOST to "www.columbinetherapy.com" (or your apex) to enable.
  if (canonical = ENV["CANONICAL_HOST"]).present?
    require "rack/rewrite"
    config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
      r301 %r{\A(?!/up).*\z}, ->(env) {
        req_host = env["HTTP_HOST"]
        uri = Rack::Request.new(env).fullpath
        if req_host != canonical
          "https://#{canonical}#{uri}"
        end
      }
    end
  end
end
