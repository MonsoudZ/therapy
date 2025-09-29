class ContactRequestMailer < ApplicationMailer
  default to: -> { Rails.application.credentials.dig(:contact, :to_email) || "owner@example.com" },
          from: -> { Rails.application.credentials.dig(:contact, :from_email) || "no-reply@#{Rails.application.config.hosts.first || 'example.com'}" }

  def new_request
    @contact_request = params[:contact_request]
    mail(subject: "New Contact Request: #{@contact_request.subject}")
  end
end
