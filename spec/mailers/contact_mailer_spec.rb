require 'rails_helper'

RSpec.describe 'Contact mail enqueue', type: :request do
  it 'enqueues email from ContactsFormController#create' do
    ActiveJob::Base.queue_adapter = :test
    expect {
      post contact_path, params: { contact: { name: 'T', email: 't@example.com', message: 'Hi' } }
    }.to have_enqueued_job(ActionMailer::MailDeliveryJob)
  end
end
