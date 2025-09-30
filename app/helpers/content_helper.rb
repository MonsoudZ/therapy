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
    filename = case sid
    when "anxiety"          then "anxiety.svg"
    when "depression"       then "depression.svg"
    when "relationships"    then "relationships.svg"
    when "grief"            then "grief.svg"
    when "health"           then "health.svg"
    when "military"         then "military.svg"
    when "trauma-resolution" then "trauma.svg"
    else
                 (service[:image] || service["image"]).presence || "placeholder-service.svg"
    end
    image_tag filename, { alt: "" }.merge(options)
  end
end
