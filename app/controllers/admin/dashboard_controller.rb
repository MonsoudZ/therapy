class Admin::DashboardController < Admin::BaseController
  def index
    @site_contents = SiteContent.all
    @recent_contacts = ContactRequest.order(created_at: :desc).limit(5)
  end
end
