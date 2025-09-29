class ContactRequest < ApplicationRecord
  validates :first_name, :last_name, :email, :state, :subject, :message, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
