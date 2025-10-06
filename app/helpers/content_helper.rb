module ContentHelper
  # Database-less setup: site_content method removed
  # Content is now hardcoded in controllers

  def professional_photo(size = "medium", options = {})
    render "shared/professional_photo",
           size: size,
           show_title: options[:show_title] != false,
           show_subtitle: options[:show_subtitle] != false,
           class: options[:class]
  end

  def cta_section(title, button_text, button_path, options = {})
    render "shared/cta_section",
           title: title,
           button_text: button_text,
           button_path: button_path
  end

  def hero_section(title, subtitle, primary_button, secondary_button, options = {})
    render "shared/hero_section",
           title: title,
           subtitle: subtitle,
           primary_button: primary_button,
           secondary_button: secondary_button
  end

  def service_icon_for(service, options = {})
    sid = service[:id] || service["id"]
    # Prefer explicit image provided by the service hash; otherwise fall back by ID
    filename = (service[:image] || service["image"]).presence || (
      case sid
      when "individual-therapy"       then "couples.jpg"
      when "couples-therapy"          then "individual.jpg"
      when "supervision-consultation" then "supervision.jpg"
      else
        "placeholder-service.svg"
      end
    )

    # Use asset pipeline for all images
    # If a descriptive title exists, use it for alt; otherwise mark decorative
    alt_text = service[:title].present? ? service[:title] : ""
    # Provide intrinsic dimensions to reduce layout shift where possible
    default_dims = { width: 800, height: 800 }
    dims = default_dims.merge(options.slice(:width, :height))
    image_tag filename, { alt: alt_text, loading: "lazy" }.merge(dims).merge(options.except(:width, :height))
  end
end
