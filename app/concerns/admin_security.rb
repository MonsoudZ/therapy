module AdminSecurity
  extend ActiveSupport::Concern

  def log_admin_action(action, resource = nil)
    Rails.logger.info "Admin #{current_admin.email} performed #{action}" +
                      (resource ? " on #{resource.class.name} ##{resource.id}" : "")
  end

  def require_admin_permission(permission)
    # You could add role-based permissions here
    # For now, all admins have all permissions
    true
  end

  def sanitize_admin_input(input)
    # Basic input sanitization
    ActionController::Base.helpers.sanitize(input, tags: %w[p br strong em ul ol li])
  end

  def validate_admin_access
    # You could add IP restrictions or other security measures here
    true
  end

  def admin_activity_log(activity, details = {})
    # You could add activity logging here
    Rails.logger.info "Admin activity: #{activity} - #{details}"
  end
end
