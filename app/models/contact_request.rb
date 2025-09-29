class ContactRequest < ApplicationRecord
  include Searchable

  validates :first_name, :last_name, :email, :state, :subject, :message, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :recent, -> { order(created_at: :desc) }
  scope :by_state, ->(state) { where(state: state) }
  scope :by_subject, ->(subject) { where("subject ILIKE ?", "%#{subject}%") }

  def full_name
    "#{first_name} #{last_name}"
  end

  def display_name
    "#{first_name} #{last_name}"
  end

  def created_at_formatted
    created_at.strftime("%B %d, %Y at %I:%M %p")
  end
end
