class SiteDataService
  def self.services
    @services ||= load_services
  end

  def self.faqs
    @faqs ||= load_faqs
  end

  def self.home_services
    @home_services ||= load_home_services
  end

  def self.find_service(id)
    services.find { |service| service[:id] == id }
  end

  private

  def self.load_services
    data = YAML.load_file(Rails.root.join('config', 'services.yml'))
    data['services'].map(&:deep_symbolize_keys)
  end

  def self.load_faqs
    data = YAML.load_file(Rails.root.join('config', 'services.yml'))
    data['faqs'].map(&:deep_symbolize_keys)
  end

  def self.load_home_services
    data = YAML.load_file(Rails.root.join('config', 'services.yml'))
    data['home_services'].map(&:deep_symbolize_keys)
  end
end
