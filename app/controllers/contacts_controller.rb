class ContactsController < ApplicationController
  def new; end

  def create
    name    = params.require(:contact)[:name]
    email   = params.require(:contact)[:email]
    message = params.require(:contact)[:message]

    ContactMailer.contact_email(name:, email:, message:).deliver_later
    redirect_to root_path, notice: "Thanks! We'll be in touch."
  rescue ActionController::ParameterMissing
    redirect_to contact_path, alert: "Please fill out all fields."
  end
end
