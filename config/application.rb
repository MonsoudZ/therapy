require_relative "boot"

# require "rails/all"
require "action_controller/railtie"
require "action_view/railtie"
require "action_mailer/railtie"
require "active_job/railtie"
# require "active_record/railtie" # ❌ no DB
# require "active_storage/engine" # ❌ if you don't need uploads
# require "action_text/engine"    # ❌ needs AR
# require "sprockets/railtie"       # using propshaft instead

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ColumbineTherapy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Ensure concerns are autoloaded/eager loaded (e.g., `app/concerns/searchable.rb`)
    config.autoload_paths << Rails.root.join("app/concerns")
    config.eager_load_paths << Rails.root.join("app/concerns")

    # prevent AR files on generators
    config.generators { |g| g.orm nil }

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
