require 'rails_helper'

RSpec.describe "Contact", type: :request do
  it "GET /contact renders successfully" do
    get contact_path
    expect(response).to have_http_status(:ok)
  end

  it "POST /contact creates and redirects (HTML)" do
    post contact_path, params: { contact: { name: "Test", email: "a@b.com", message: "Hi" } }
    expect(response).to have_http_status(302).or have_http_status(303)
  end
end
