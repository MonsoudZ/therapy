class PagesController < ApplicationController
  def home
    @home_services = load_home_services
  end

  def about
  end

  def services
    @services = load_services
  end

  def service_detail
    @service = find_service(params[:id])
    return head :not_found unless @service

    frame_id = "service-detail-#{@service[:id]}"

    render inline: view_context.turbo_frame_tag(frame_id) {
      view_context.render("pages/service_detail", service: @service)
    }, layout: false
  end

  def service_detail_close
    id = params[:id]
    render inline: view_context.turbo_frame_tag("service-detail-#{id}", ""), layout: false
  end

  def faqs
    @faqs = load_faqs
  end

  private

  def load_home_services
    [
      { title: "Individual Therapy", description: "Personalized support to help you process, heal, and grow." },
      { title: "Couples Therapy", description: "Strengthen communication, resolve conflict, and rebuild connection." },
      { title: "Supervision / Consultation", description: "Clinical supervision and consultation for therapists and teams." }
    ]
  end

  def load_services
    [
      { id: "individual-therapy", title: "Individual Therapy", description: "A collaborative, tailored approach to help you clarify patterns, process painful experiences, and move toward a life that feels more grounded, connected, and authentic.", image: "individual.jpg" },
      { id: "couples-therapy", title: "Couples Therapy", description: "Support for partners to improve communication, repair trust, and deepen intimacy. We'll slow down reactive cycles and build skills for real connection.", image: "couples.jpg" },
      { id: "supervision-consultation", title: "Supervision / Consultation", description: "Reflective, strengths-based supervision and consultation for clinicians seeking growth, support with complex cases, or refinement of relational/trauma-informed practice.", image: "supervision.jpg" }
    ]
  end

  def find_service(id)
    load_services.find { |service| service[:id] == id }
  end

  def load_faqs
    [
      { question: "What is your approach to therapy?", answer: "I use evidence-based approaches including EMDR, CBT, and other proven methods tailored to your specific needs." },
      { question: "How long are sessions?", answer: "Sessions are typically 50 minutes long, though we can adjust based on your needs." },
      { question: "Do you offer virtual sessions?", answer: "Yes, I offer both in-person and virtual sessions to accommodate your schedule and preferences." }
    ]
  end
end
