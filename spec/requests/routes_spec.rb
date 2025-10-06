require 'rails_helper'

RSpec.describe 'Routes', type: :request do
  it 'has services detail route helper' do
    expect { detail_service_path(1) }.not_to raise_error
    expect { detail_close_service_path(1) }.not_to raise_error
  end

  it 'has contact routes' do
    expect { contact_path }.not_to raise_error
  end
end
