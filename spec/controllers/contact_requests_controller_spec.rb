require 'rails_helper'

RSpec.describe ContactRequestsController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'assigns a new contact request' do
      get :new
      expect(assigns(:contact_request)).to be_a_new(ContactRequest)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          contact_request: {
            first_name: 'John',
            last_name: 'Doe',
            email: 'john@example.com',
            state: 'CA',
            subject: 'Test Subject',
            message: 'Test message'
          }
        }
      end

      it 'creates a new contact request' do
        expect {
          post :create, params: valid_attributes
        }.to change(ContactRequest, :count).by(1)
      end

      it 'redirects to contact path with success message' do
        post :create, params: valid_attributes
        expect(response).to redirect_to(contact_path)
        expect(flash[:notice]).to eq("Thanks — I'll be in touch within 24–48 hours.")
      end

      it 'sends an email' do
        expect {
          post :create, params: valid_attributes
        }.to have_enqueued_mail(ContactRequestMailer, :new_request)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          contact_request: {
            first_name: '',
            last_name: '',
            email: 'invalid-email',
            state: '',
            subject: '',
            message: ''
          }
        }
      end

      it 'does not create a new contact request' do
        expect {
          post :create, params: invalid_attributes
        }.not_to change(ContactRequest, :count)
      end

      it 'renders the new template' do
        post :create, params: invalid_attributes
        expect(response).to render_template(:new)
      end

      it 'sets flash alert' do
        post :create, params: invalid_attributes
        expect(flash[:alert]).to eq('Please fix the errors below.')
      end
    end
  end
end
