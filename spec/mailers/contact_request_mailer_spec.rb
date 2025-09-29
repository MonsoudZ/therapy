require 'rails_helper'

RSpec.describe ContactRequestMailer, type: :mailer do
  describe '#new_request' do
    let(:contact_request) { create(:contact_request) }
    let(:mail) { ContactRequestMailer.with(contact_request: contact_request).new_request }

    it 'renders the headers' do
      expect(mail.subject).to eq("New Contact Request: #{contact_request.subject}")
      expect(mail.to).to eq(['owner@example.com'])
      expect(mail.from).to eq(['no-reply@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include(contact_request.first_name)
      expect(mail.body.encoded).to include(contact_request.last_name)
      expect(mail.body.encoded).to include(contact_request.email)
      expect(mail.body.encoded).to include(contact_request.message)
    end
  end
end
