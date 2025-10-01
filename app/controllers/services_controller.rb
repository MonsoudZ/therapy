class ServicesController < ApplicationController
  def index
    @services = load_services
  end

  def detail
    @service = find_service(params[:id])
    return head :not_found unless @service

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(
            "service-toggle-#{@service[:id]}",
            partial: "services/close_button",
            locals: { service: @service }
          ),
          turbo_stream.update(
            "service-detail-#{@service[:id]}",
            partial: "services/service_description",
            locals: { service: @service }
          )
        ]
      end
    end
  end

  def close
    service = find_service(params[:id])

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(
            "service-toggle-#{params[:id]}",
            partial: "services/open_button",
            locals: { service: service }
          ),
          turbo_stream.update(
            "service-detail-#{params[:id]}",
            ""
          )
        ]
      end
    end
  end

  private

  def load_services
    [
      { id: "individual-therapy", title: "Individual Therapy", description: "One-on-one personalized therapy sessions tailored to your unique needs and goals.", teaser: "Personalized sessions", image: "individual.jpg" },
      { id: "couples-therapy", title: "Couples Therapy", description: "Strengthen your relationship through guided therapy focused on communication and connection.", teaser: "Strengthen relationships", image: "couples.jpg" },
      { id: "supervision-consultation", title: "Supervision / Consultation", description: "Professional guidance for therapists and counselors seeking to enhance their practice.", teaser: "Professional guidance", image: "supervision.jpg" }
    ]
  end

  def find_service(id)
    load_services.find { |s| s[:id] == id }
  end
end
