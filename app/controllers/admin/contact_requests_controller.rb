class Admin::ContactRequestsController < Admin::BaseController
  def index
    @contact_requests = ContactRequest.order(created_at: :desc)
  end

  def show
    @contact_request = ContactRequest.find(params[:id])
  end

  def destroy
    @contact_request = ContactRequest.find(params[:id])
    @contact_request.destroy
    redirect_to admin_contact_requests_path, notice: 'Contact request was successfully deleted.'
  end
end
