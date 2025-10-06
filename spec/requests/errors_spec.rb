require 'rails_helper'

RSpec.describe 'Custom error pages', type: :request do
  it 'returns 404 for a missing route' do
    get '/totally-missing'
    expect(response).to have_http_status(:not_found)
  end

  it 'serves the 404 page endpoint (status 200)' do
    get '/404'
    expect(response).to have_http_status(:ok)
  end

  it 'serves the 422 page endpoint (status 200)' do
    get '/422'
    expect(response).to have_http_status(:ok)
  end

  it 'serves the 500 page endpoint (status 200)' do
    get '/500'
    expect(response).to have_http_status(:ok)
  end
end



