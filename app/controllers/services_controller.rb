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
    [
      { id: 1, title: "Individual Therapy", description: "One-on-one personalized therapy sessions tailored to your unique needs and goals.", teaser: "Personalized sessions", image: "individual.jpg" },
      { id: 2, title: "Couples Therapy", description: "Strengthen your relationship through guided therapy focused on communication and connection.", teaser: "Strengthen relationships", image: "couples.jpg" },
      { id: 3, title: "Supervision / Consultation", description: "Professional guidance for therapists and counselors seeking to enhance their practice.", teaser: "Professional guidance", image: "supervision.jpg" }
    ]
  end

  def find_service(id)
    load_services.find { |s| s[:id].to_s == id.to_s }
  end
end
