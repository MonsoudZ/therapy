module ContentHelper
  def site_content(key, default = nil)
    content = SiteContent.find_by(key: key)
    return default if content.nil?
    
    case content.content_type
    when "html"
      content.content.html_safe
    when "markdown"
      # You could add a markdown processor here if needed
      content.content.html_safe
    else
      content.content
    end
  end

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
end
