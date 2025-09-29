class Admin::DashboardController < Admin::BaseController
  def index
    @total_contact_requests = ContactRequest.count
    @recent_contact_requests = ContactRequest.recent.limit(5)
    @total_site_contents = SiteContent.count
  end
end
