require "active_model"
class ContactForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :email, :string
  attribute :message, :string
  attribute :phone, :string
  attribute :state, :string
  attribute :referral_source, :string

  validates :name, :email, :message, :state, presence: true
  validates :message, length: { minimum: 10 }, allow_blank: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email" }, allow_blank: true

  def to_h
    {
      name: name,
      email: email,
      message: message,
      phone: phone,
      state: state,
      referral_source: referral_source
    }
  end
end


