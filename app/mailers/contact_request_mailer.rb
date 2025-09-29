class ContactRequestMailer < ApplicationMailer
  default to: -> { ENV.fetch("CONTACT_TO_EMAIL", Rails.application.credentials.dig(:contact, :to_email) || "angela@angelakeeley.com") },
          from: -> { ENV.fetch("CONTACT_FROM_EMAIL", Rails.application.credentials.dig(:contact, :from_email) || "noreply@#{ENV.fetch('RAILS_HOST', 'example.com')}") }

  def new_request
    @contact_request = params[:contact_request]
    mail(subject: "New Contact Request: #{@contact_request.subject}")
  end
end
