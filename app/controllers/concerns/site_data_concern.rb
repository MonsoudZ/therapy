module SiteDataConcern
  extend ActiveSupport::Concern

  private

  def load_services
    @services ||= SiteDataService.services
  end

  def load_faqs
    @faqs ||= SiteDataService.faqs
  end

  def load_home_services
    @home_services ||= SiteDataService.home_services
  end
end
