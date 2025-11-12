class SitemapController < ApplicationController
  def index
    @base_url = request.base_url
    @pages = [
      { path: root_path, priority: 1.0, changefreq: 'weekly' },
      { path: about_path, priority: 0.8, changefreq: 'monthly' },
      { path: services_path, priority: 0.9, changefreq: 'monthly' },
      { path: faqs_path, priority: 0.7, changefreq: 'monthly' },
      { path: contact_path, priority: 0.8, changefreq: 'monthly' }
    ]
    
    # Note: Service detail pages are turbo_stream routes, not indexable pages
    # Only the main services index page is included
    
    respond_to do |format|
      format.xml
    end
  end
  
  private
  
  def load_services
    @loaded_services ||= begin
      YAML.load_file(Rails.root.join("config/services.yml")).map(&:symbolize_keys)
    rescue
      []
    end
  end
end

