require 'rails_helper'

RSpec.describe Admin::ContactRequestsController, type: :controller do
  let(:admin) { FactoryBot.create(:admin) }
  let(:contact_request) { FactoryBot.create(:contact_request) }

  before { sign_in admin }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns contact_requests" do
      contact_request
      get :index
      expect(assigns(:contact_requests)).to include(contact_request)
    end

    it "orders contact_requests by created_at desc" do
      old_request = FactoryBot.create(:contact_request, created_at: 2.days.ago)
      new_request = FactoryBot.create(:contact_request, created_at: 1.day.ago)

      get :index
      contact_requests = assigns(:contact_requests)
      expect(contact_requests.first).to eq(new_request)
      expect(contact_requests.last).to eq(old_request)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: contact_request.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get :show, params: { id: contact_request.id }
      expect(response).to render_template(:show)
    end

    it "assigns contact_request" do
      get :show, params: { id: contact_request.id }
      expect(assigns(:contact_request)).to eq(contact_request)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the contact_request" do
      contact_request
      expect {
        delete :destroy, params: { id: contact_request.id }
      }.to change(ContactRequest, :count).by(-1)
    end

    it "redirects to contact_requests index" do
      delete :destroy, params: { id: contact_request.id }
      expect(response).to redirect_to(admin_contact_requests_path)
    end

    it "sets flash notice" do
      delete :destroy, params: { id: contact_request.id }
      expect(flash[:notice]).to eq("Contact request was successfully deleted.")
    end
  end

  context "when admin is not authenticated" do
    before { sign_out admin }

    it "redirects to login for all actions" do
      get :index
      expect(response).to redirect_to(new_admin_session_path)
    end
  end
end
