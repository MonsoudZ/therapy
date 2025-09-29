class ContactRequestsController < ApplicationController
  def new
    @contact_request = ContactRequest.new
  end

  def create
    @contact_request = ContactRequest.new(contact_request_params)
    if @contact_request.save
      ContactRequestMailer.with(contact_request: @contact_request).new_request.deliver_later
      redirect_to contact_path, notice: "Thanks — I'll be in touch within 24–48 hours."
    else
      flash.now[:alert] = "Please fix the errors below."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_request_params
    params.require(:contact_request).permit(:first_name, :last_name, :email, :phone, :state, :subject, :message, :referral)
  end
end
