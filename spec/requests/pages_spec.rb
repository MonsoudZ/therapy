require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  describe 'GET /' do
    it 'returns http success' do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the home template' do
      get root_path
      expect(response).to render_template(:home)
    end
  end

  describe 'GET /about' do
    it 'returns http success' do
      get about_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the about template' do
      get about_path
      expect(response).to render_template(:about)
    end
  end

  describe 'GET /services' do
    it 'returns http success' do
      get services_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the services template' do
      get services_path
      expect(response).to render_template(:services)
    end
  end

  describe 'GET /faqs' do
    it 'returns http success' do
      get faqs_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the faqs template' do
      get faqs_path
      expect(response).to render_template(:faqs)
    end
  end

  describe 'GET /contact' do
    it 'returns http success' do
      get contact_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the contact form' do
      get contact_path
      expect(response).to render_template('contact_requests/new')
    end
  end
end
