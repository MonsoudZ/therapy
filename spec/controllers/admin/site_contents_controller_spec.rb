require 'rails_helper'

RSpec.describe Admin::SiteContentsController, type: :controller do
  let(:admin) { FactoryBot.create(:admin) }
  let(:site_content) { FactoryBot.create(:site_content) }

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

    it "assigns site_contents" do
      site_content
      get :index
      expect(assigns(:site_contents)).to include(site_content)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: site_content.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get :show, params: { id: site_content.id }
      expect(response).to render_template(:show)
    end

    it "assigns site_content" do
      get :show, params: { id: site_content.id }
      expect(assigns(:site_content)).to eq(site_content)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns a new site_content" do
      get :new
      expect(assigns(:site_content)).to be_a_new(SiteContent)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_attributes) { FactoryBot.attributes_for(:site_content) }

      it "creates a new site_content" do
        expect {
          post :create, params: { site_content: valid_attributes }
        }.to change(SiteContent, :count).by(1)
      end

      it "redirects to the site_content" do
        post :create, params: { site_content: valid_attributes }
        expect(response).to redirect_to(admin_site_content_path(SiteContent.last))
      end

      it "sets flash notice" do
        post :create, params: { site_content: valid_attributes }
        expect(flash[:notice]).to eq("Site content was successfully created.")
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { FactoryBot.attributes_for(:site_content, key: nil) }

      it "does not create a new site_content" do
        expect {
          post :create, params: { site_content: invalid_attributes }
        }.not_to change(SiteContent, :count)
      end

      it "renders the new template" do
        post :create, params: { site_content: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { id: site_content.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the edit template" do
      get :edit, params: { id: site_content.id }
      expect(response).to render_template(:edit)
    end

    it "assigns site_content" do
      get :edit, params: { id: site_content.id }
      expect(assigns(:site_content)).to eq(site_content)
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      let(:new_attributes) { { title: "Updated Title" } }

      it "updates the site_content" do
        patch :update, params: { id: site_content.id, site_content: new_attributes }
        site_content.reload
        expect(site_content.title).to eq("Updated Title")
      end

      it "redirects to the site_content" do
        patch :update, params: { id: site_content.id, site_content: new_attributes }
        expect(response).to redirect_to(admin_site_content_path(site_content))
      end

      it "sets flash notice" do
        patch :update, params: { id: site_content.id, site_content: new_attributes }
        expect(flash[:notice]).to eq("Site content was successfully updated.")
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { key: nil } }

      it "does not update the site_content" do
        original_key = site_content.key
        patch :update, params: { id: site_content.id, site_content: invalid_attributes }
        site_content.reload
        expect(site_content.key).to eq(original_key)
      end

      it "renders the edit template" do
        patch :update, params: { id: site_content.id, site_content: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the site_content" do
      site_content
      expect {
        delete :destroy, params: { id: site_content.id }
      }.to change(SiteContent, :count).by(-1)
    end

    it "redirects to site_contents index" do
      delete :destroy, params: { id: site_content.id }
      expect(response).to redirect_to(admin_site_contents_path)
    end

    it "sets flash notice" do
      delete :destroy, params: { id: site_content.id }
      expect(flash[:notice]).to eq("Site content was successfully deleted.")
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
