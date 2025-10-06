require 'rails_helper'

RSpec.describe 'Contact mail enqueue', type: :request do
  it 'enqueues email from ContactsFormController#create' do
    ActiveJob::Base.queue_adapter = :test
    expect {
      post contact_path, params: {
        contact: {
          name: 'Test User',
          email: 't@example.com',
          state: 'CO',
          message: 'This is a valid message body.'
        }
      }
    }.to have_enqueued_job(ActionMailer::MailDeliveryJob)
  end
end
