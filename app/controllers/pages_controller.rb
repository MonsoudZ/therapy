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
    unless @service
      redirect_to services_path and return
    end

    if turbo_frame_request?
      # Render the template that wraps the partial in the correct Turbo Frame id
      render template: "pages/service_detail", layout: false and return
    end
  end

  # Turbo helper to clear a frame
  def service_detail_close
    @service = { id: params[:id] }
    render inline: view_context.turbo_frame_tag("service-detail-#{params[:id]}", ""), layout: false
  end

  def faqs
    @faqs = load_faqs
  end

  private

  def load_home_services
    [
      { title: "Trauma Resolution", description: "Healing from traumatic experiences" },
      { title: "Anxiety", description: "Managing anxiety and stress" },
      { title: "Depression", description: "Support for depression and mood" }
    ]
  end

  def load_services
    [
      { id: "trauma-resolution", title: "Trauma Resolution", description: "Using EMDR and other evidence-based approaches to help you process and heal from traumatic experiences. We'll work together to build resilience and reclaim your sense of safety and control.", image: "mountain.jpg" },
      { id: "anxiety", title: "Anxiety", description: "Whether it's generalized anxiety, panic attacks, or social anxiety, we'll explore the roots of your worry and develop practical tools to manage symptoms and build confidence.", image: "mountain.jpg" },
      { id: "depression", title: "Depression", description: "Support for depression and mood disorders through evidence-based approaches that help you regain your sense of hope and well-being.", image: "mountain.jpg" },
      { id: "relationships", title: "Relationships", description: "Improving communication, resolving conflicts, and building stronger connections with the important people in your life.", image: "mountain.jpg" },
      { id: "grief", title: "Grief", description: "Navigating loss and grief with compassion and support as you work through the complex emotions that come with significant life changes.", image: "mountain.jpg" },
      { id: "health", title: "Health", description: "Supporting your mental health journey with a focus on overall wellness and coping strategies for life's challenges.", image: "mountain.jpg" },
      { id: "military", title: "Military", description: "Specialized support for military personnel and veterans dealing with the unique challenges of service and transition.", image: "mountain.jpg" }
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
