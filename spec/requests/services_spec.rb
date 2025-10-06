require 'rails_helper'

RSpec.describe "Services", type: :request do
  describe "GET /services" do
    it "renders the index successfully" do
      get services_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /services/:id/detail (turbo_stream)" do
    it "returns turbo_stream with targeted ids" do
      get detail_service_path(1), headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }
      expect(response.media_type).to eq('text/vnd.turbo-stream.html')
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('turbo-stream action="update" target="service-toggle-1-individual-therapy"')
      expect(response.body).to include('turbo-stream action="update" target="service-detail-1-individual-therapy"')
    end
  end

  describe "GET /services/:id/detail (html)" do
    it "still responds 200 with turbo-stream body when requested as html" do
      get detail_service_path(1) # html default
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('<turbo-stream')
    end
  end

  describe "GET /services/:id/detail unknown id" do
    it "returns 404" do
      get detail_service_path(999), headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }
      expect(response).to have_http_status(404)
    end
  end

  describe "GET /services/:id/detail/close (turbo_stream)" do
    it "returns turbo_stream that clears detail frame" do
      get detail_close_service_path(1), headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }
      expect(response.media_type).to eq('text/vnd.turbo-stream.html')
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('turbo-stream action="update" target="service-toggle-1-individual-therapy"')
      expect(response.body).to include('turbo-stream action="update" target="service-detail-1-individual-therapy"')
    end
  end
end
