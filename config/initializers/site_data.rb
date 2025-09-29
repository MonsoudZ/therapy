# Site Data Configuration
# This initializer sets up the site data service and ensures proper caching

# Simple configuration for production
Rails.application.config.after_initialize do
  # Ensure SiteDataService is available
  if defined?(SiteDataService)
    Rails.logger.info "SiteDataService initialized"
  end
end
