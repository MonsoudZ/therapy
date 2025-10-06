# app/controllers/contacts_form_controller.rb
class ContactsFormController < ApplicationController
  before_action :throttle_contact_submissions!, only: :create
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
          render turbo_stream: [
            turbo_stream.replace("contact_form", partial: "contacts_form/empty_form")
          ]
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

  # Basic, in-process rate limiting by IP. Allows 1 submission every 15 seconds
  # and at most 5 submissions per hour per IP. Uses Rails.cache; suitable for
  # low-volume forms without external dependencies.
  def throttle_contact_submissions!
    ip = request.remote_ip.presence || "unknown"
    now = Time.current.to_i

    last_key = "contact:last:#{ip}"
    hour_key = "contact:hour:#{ip}:#{Time.current.strftime('%Y%m%d%H')}"

    last_ts = Rails.cache.read(last_key).to_i
    count = (Rails.cache.read(hour_key) || 0).to_i

    min_interval = 15 # seconds between submissions
    hourly_limit = 5   # max submissions per hour

    if last_ts.positive? && (now - last_ts) < min_interval
      return render_throttled(min_interval - (now - last_ts))
    end

    if count >= hourly_limit
      return render_throttled(3600)
    end

    # Record this attempt (even if later validation fails) to prevent abuse
    Rails.cache.write(last_key, now, expires_in: 1.hour)
    Rails.cache.write(hour_key, count + 1, expires_in: 1.hour)
  end

  def render_throttled(retry_after)
    response.set_header("Retry-After", retry_after.to_i)
    respond_to do |format|
      format.turbo_stream do
        flash.now[:alert] = "Please wait before submitting again. Try in #{retry_after.to_i} seconds."
        render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash_messages"), status: :too_many_requests
      end
      format.html do
        redirect_to contact_path, alert: "Please wait before submitting again."
      end
    end
  end
end
