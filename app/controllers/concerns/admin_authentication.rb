module AdminAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_admin!
    before_action :set_admin_user
  end

  private

  def set_admin_user
    @current_admin = current_admin
  end

  def current_admin
    @current_admin ||= super
  end

  def admin_signed_in?
    admin_signed_in?
  end

  def require_admin!
    redirect_to new_admin_session_path unless admin_signed_in?
  end
end
