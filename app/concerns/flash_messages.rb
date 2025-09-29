module FlashMessages
  extend ActiveSupport::Concern

  def flash_success(message)
    flash[:notice] = message
  end

  def flash_error(message)
    flash[:alert] = message
  end

  def flash_info(message)
    flash[:info] = message
  end

  def flash_warning(message)
    flash[:warning] = message
  end

  def render_flash_messages
    render "shared/flash_messages"
  end
end
