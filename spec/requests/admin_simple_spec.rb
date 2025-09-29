require 'rails_helper'

RSpec.describe "Admin System", type: :request do
  describe "Admin routes" do
    it "redirects to login when not authenticated" do
      get admin_root_path
      expect(response).to redirect_to(new_admin_session_path)
    end

    it "redirects site contents to login when not authenticated" do
      get admin_site_contents_path
      expect(response).to redirect_to(new_admin_session_path)
    end

    it "redirects contact requests to login when not authenticated" do
      get admin_contact_requests_path
      expect(response).to redirect_to(new_admin_session_path)
    end
  end

  describe "Admin login" do
    it "shows login form" do
      get new_admin_session_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Log in")
    end
  end
end
