# app/controllers/contacts_form_controller.rb
class ContactsFormController < ApplicationController
  def new
    @contact = ContactForm.new
  end

  def create
    @contact = ContactForm.new(contact_params)

    if @contact.valid?
      details = []
      details << "Phone: #{@contact.phone}" if @contact.phone.present?
      details << "State/Location: #{@contact.state}" if @contact.state.present?
      details << "Referral source: #{@contact.referral_source}" if @contact.referral_source.present?
      full_message = [ @contact.message, (details.any? ? "\n\n---\n" + details.join("\n") : nil) ].compact.join

      ContactMailer.contact_email(
        name:    @contact.name,
        email:   @contact.email,
        message: full_message
      ).deliver_later

      respond_to do |format|
        format.turbo_stream do
          flash.now[:notice] = "Message sent. Thanks!"
          render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash_messages")
        end
        format.html { redirect_to contact_path, notice: "Message sent. Thanks!" }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          flash.now[:alert] = @contact.errors.full_messages.to_sentence
          render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash_messages")
        end
        format.html do
          flash[:alert] = @contact.errors.full_messages.to_sentence
          redirect_to contact_path
        end
      end
    end
  rescue ActionController::ParameterMissing
    respond_to do |format|
      format.turbo_stream do
        flash.now[:alert] = "Please fill out all required fields."
        render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash_messages")
      end
      format.html { redirect_to contact_path, alert: "Please fill out all required fields." }
    end
  rescue => e
    Rails.logger.error("[ContactForm] #{e.class}: #{e.message}")
    respond_to do |format|
      format.turbo_stream do
        flash.now[:alert] = "Something went wrong."
        render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash_messages")
      end
      format.html { redirect_to contact_path, alert: "Something went wrong." }
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message, :phone, :state, :referral_source)
  end
end
