class SiteDataService
  include ActiveSupport::Configurable

  class << self
    def services
      Rails.cache.fetch("site_data_services", expires_in: 1.hour) do
        load_services
      end
    end

    def faqs
      Rails.cache.fetch("site_data_faqs", expires_in: 1.hour) do
        load_faqs
      end
    end

    def home_services
      Rails.cache.fetch("site_data_home_services", expires_in: 1.hour) do
        load_home_services
      end
    end

    def find_service(id)
      services.find { |service| service[:id] == id }
    end

    def clear_cache!
      Rails.cache.delete_matched("site_data_*")
    end

    private

    def load_services
      data = YAML.load_file(Rails.root.join("config", "services.yml"))
      data["services"].map(&:deep_symbolize_keys)
    end

    def load_faqs
      data = YAML.load_file(Rails.root.join("config", "services.yml"))
      data["faqs"].map(&:deep_symbolize_keys)
    end

    def load_home_services
      data = YAML.load_file(Rails.root.join("config", "services.yml"))
      data["home_services"].map(&:deep_symbolize_keys)
    end
  end
end
