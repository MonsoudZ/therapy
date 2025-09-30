class ContactsController < ApplicationController
  def new; end

  def create
    name     = params.require(:contact)[:name]
    email    = params.require(:contact)[:email]
    message  = params.require(:contact)[:message]
    phone    = params.dig(:contact, :phone)
    state    = params.dig(:contact, :state)
    referral = params.dig(:contact, :referral_source)

    details = []
    details << "Phone: #{phone}" if phone.present?
    details << "State/Location: #{state}" if state.present?
    details << "Referral source: #{referral}" if referral.present?

    full_message = [ message, (details.any? ? "\n\n---\n" + details.join("\n") : nil) ].compact.join

    ContactMailer.contact_email(name:, email:, message: full_message).deliver_later
    redirect_to root_path, notice: "Thanks! We'll be in touch."
  rescue ActionController::ParameterMissing
    redirect_to contact_path, alert: "Please fill out all fields."
  end
end
