class ServicesController < ApplicationController
  def index
    @services = load_services
  end

  def detail
    @service = find_service(params[:id])
    return head :not_found unless @service

    render partial: "services/service_detail", locals: { service: @service }, layout: false
  end

  def close
    render html: turbo_frame_tag("service-detail-#{params[:id]}", ""), layout: false
  end

  private

  def load_services
    [
      { id: "individual-therapy", title: "Individual Therapy", description: "One-on-one personalized therapy sessions tailored to your needs...", teaser: "Personalized sessions", image: "individual.jpg" },
      { id: "couples-therapy", title: "Couples Therapy", description: "Strengthen your relationship through guided therapy...", teaser: "Strengthen relationships", image: "couples.jpg" },
      { id: "supervision-consultation", title: "Supervision / Consultation", description: "Professional guidance for therapists and counselors...", teaser: "Professional guidance", image: "supervision.jpg" }
    ]
  end

  def find_service(id)
    load_services.find { |s| s[:id] == id }
  end
end
