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
      when "individual-therapy"       then "individual.jpg"
      when "couples-therapy"          then "couples.jpg"
      when "supervision-consultation" then "supervision.jpg"
      else
        "placeholder-service.svg"
      end
    )

    # Use public path for all .jpg files, asset path for others
    if filename.end_with?(".jpg")
      image_tag "/#{filename}", { alt: "" }.merge(options)
    else
      image_tag filename, { alt: "" }.merge(options)
    end
  end
end
