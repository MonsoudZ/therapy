json.extract! contact_request, :id, :first_name, :last_name, :email, :phone, :state, :subject, :message, :referral, :created_at, :updated_at
json.url contact_request_url(contact_request, format: :json)
