# app/controllers/contacts_form_controller.rb
class ContactsFormController < ApplicationController
  def new
  end

  def create
    permitted = params.require(:contact).permit(:name, :email, :message, :phone, :state, :referral_source)

    # Build a single message body including optional fields
    details = []
    details << "Phone: #{permitted[:phone]}" if permitted[:phone].present?
    details << "State/Location: #{permitted[:state]}" if permitted[:state].present?
    details << "Referral source: #{permitted[:referral_source]}" if permitted[:referral_source].present?
    full_message = [ permitted[:message], (details.any? ? "\n\n---\n" + details.join("\n") : nil) ].compact.join

    # Send the email (uses Active Job; works with :async adapter)
    ContactMailer.contact_email(
      name:    permitted[:name],
      email:   permitted[:email],
      message: full_message
    ).deliver_later

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = "Message sent. Thanks!"
        render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash_messages")
      end
      format.html { redirect_to new_contact_path, notice: "Message sent. Thanks!" }
    end
  rescue ActionController::ParameterMissing
    respond_to do |format|
      format.turbo_stream do
        flash.now[:alert] = "Please fill out all required fields."
        render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash_messages")
      end
      format.html { redirect_to new_contact_path, alert: "Please fill out all required fields." }
    end
  rescue => e
    Rails.logger.error("[ContactForm] #{e.class}: #{e.message}")
    respond_to do |format|
      format.turbo_stream do
        flash.now[:alert] = "Something went wrong."
        render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash_messages")
      end
      format.html { redirect_to new_contact_path, alert: "Something went wrong." }
    end
  end
end
