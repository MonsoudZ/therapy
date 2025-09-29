class Admin::ContactRequestsController < Admin::BaseController
  before_action :set_contact_request, only: %i[ show destroy ]

  def index
    @contact_requests = ContactRequest.recent
  end

  def show
  end

  def destroy
    @contact_request.destroy!
    redirect_to admin_contact_requests_url, notice: "Contact request was successfully destroyed.", status: :see_other
  end

  private
    def set_contact_request
      @contact_request = ContactRequest.find(params[:id])
    end
end
