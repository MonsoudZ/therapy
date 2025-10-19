class ServicesController < ApplicationController
  def index
    @services = load_services
  end

  def detail
    @service = find_service(params[:id])
    return head :not_found unless @service

    key = dom_key(@service)

    request.format = :turbo_stream

    render turbo_stream: [
      turbo_stream.update(
        "service-toggle-#{key}",
        partial: "services/close_button",
        locals: { service: @service }
      ),
      turbo_stream.update(
        "service-detail-#{key}",
        partial: "services/service_description",
        locals: { service: @service }
      )
    ]
  end

  def detail_close
    @service = find_service(params[:id])
    return head :not_found unless @service

    key = dom_key(@service)

    request.format = :turbo_stream

    render turbo_stream: [
      turbo_stream.update(
        "service-toggle-#{key}",
        partial: "services/open_button",
        locals: { service: @service }
      ),
      turbo_stream.update("service-detail-#{key}", "")
    ]
  end

  private

  def dom_key(service)
    "#{service[:id]}-#{service[:title].parameterize}"
  end

  def load_services
    @loaded_services ||= begin
      YAML.load_file(Rails.root.join("config/services.yml")).map(&:symbolize_keys)
    end
  end

  def find_service(id)
    load_services.find { |s| s[:id].to_s == id.to_s }
  end
end
