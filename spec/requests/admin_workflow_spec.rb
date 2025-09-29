require 'rails_helper'

RSpec.describe "Admin Workflow", type: :request do
  let(:admin) { FactoryBot.create(:admin, email: "admin@example.com", password: "password123") }

  describe "Admin authentication flow" do
    it "redirects unauthenticated users to login" do
      get admin_root_path
      expect(response).to redirect_to(new_admin_session_path)
    end

    it "allows authenticated admins to access admin panel" do
      sign_in admin
      get admin_root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "Site content management workflow" do
    before { sign_in admin }

    it "allows creating new site content" do
      get new_admin_site_content_path
      expect(response).to have_http_status(:success)

      post admin_site_contents_path, params: {
        site_content: {
          key: "test_content",
          title: "Test Content",
          content: "This is test content",
          content_type: "text"
        }
      }

      expect(response).to redirect_to(admin_site_content_path(SiteContent.last))
      expect(SiteContent.last.key).to eq("test_content")
    end

    it "allows editing existing site content" do
      site_content = FactoryBot.create(:site_content, key: "editable_content")
      
      get edit_admin_site_content_path(site_content)
      expect(response).to have_http_status(:success)

      patch admin_site_content_path(site_content), params: {
        site_content: { title: "Updated Title" }
      }

      expect(response).to redirect_to(admin_site_content_path(site_content))
      expect(site_content.reload.title).to eq("Updated Title")
    end

    it "allows deleting site content" do
      site_content = FactoryBot.create(:site_content)
      
      expect {
        delete admin_site_content_path(site_content)
      }.to change(SiteContent, :count).by(-1)

      expect(response).to redirect_to(admin_site_contents_path)
    end
  end

  describe "Contact requests management workflow" do
    before { sign_in admin }

    it "allows viewing contact requests" do
      contact_request = FactoryBot.create(:contact_request)
      
      get admin_contact_requests_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include(contact_request.first_name)
    end

    it "allows viewing individual contact request details" do
      contact_request = FactoryBot.create(:contact_request, subject: "Test Subject")
      
      get admin_contact_request_path(contact_request)
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Test Subject")
    end

    it "allows deleting contact requests" do
      contact_request = FactoryBot.create(:contact_request)
      
      expect {
        delete admin_contact_request_path(contact_request)
      }.to change(ContactRequest, :count).by(-1)

      expect(response).to redirect_to(admin_contact_requests_path)
    end
  end

  describe "Dashboard functionality" do
    before { sign_in admin }

    it "shows statistics on dashboard" do
      FactoryBot.create(:contact_request)
      FactoryBot.create(:site_content)
      
      get admin_root_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Total Contact Requests")
      expect(response.body).to include("Site Content Items")
    end

    it "shows recent contact requests" do
      contact_request = FactoryBot.create(:contact_request, first_name: "John", last_name: "Doe")
      
      get admin_root_path
      expect(response.body).to include("John Doe")
    end
  end
end
