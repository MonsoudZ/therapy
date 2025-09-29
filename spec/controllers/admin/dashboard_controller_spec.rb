require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do
  let(:admin) { FactoryBot.create(:admin) }

  describe "GET #index" do
    context "when admin is authenticated" do
      before { sign_in admin }

      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template(:index)
      end

      it "assigns site_contents" do
        site_content = FactoryBot.create(:site_content)
        get :index
        expect(assigns(:site_contents)).to include(site_content)
      end

      it "assigns recent_contacts" do
        contact_request = FactoryBot.create(:contact_request)
        get :index
        expect(assigns(:recent_contacts)).to include(contact_request)
      end
    end

    context "when admin is not authenticated" do
      it "redirects to login" do
        get :index
        expect(response).to redirect_to(new_admin_session_path)
      end
    end
  end
end
