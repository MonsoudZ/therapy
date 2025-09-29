require 'rails_helper'

RSpec.describe ContactRequest, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:message) }

    it { should allow_value('test@example.com').for(:email) }
    it { should allow_value('user@domain.org').for(:email) }
    it { should_not allow_value('invalid-email').for(:email) }
    it { should_not allow_value('test@').for(:email) }
  end

  describe 'associations' do
    # Add any associations if they exist
  end

  describe 'callbacks' do
    # Add any callback tests if they exist
  end

  describe 'scopes' do
    # Add any scope tests if they exist
  end

  describe 'instance methods' do
    let(:contact_request) { build(:contact_request) }

    it 'is valid with valid attributes' do
      expect(contact_request).to be_valid
    end
  end
end
