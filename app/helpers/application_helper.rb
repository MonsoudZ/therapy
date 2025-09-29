module ApplicationHelper
  def cta_button(text, path, options = {})
    default_classes = "rounded-xl px-6 sm:px-8 py-3 sm:py-4 text-white font-medium text-base sm:text-lg hover:opacity-90 transition-opacity"
    classes = options[:class] || default_classes
    style = options[:style] || "background-color: #416970;"
    
    link_to text, path, class: classes, style: style
  end

  def secondary_button(text, path, options = {})
    default_classes = "rounded-xl border-2 border-[#416970] px-6 sm:px-8 py-3 sm:py-4 text-[#416970] font-medium text-base sm:text-lg hover:bg-[#416970] hover:text-white transition-colors"
    classes = options[:class] || default_classes
    
    link_to text, path, class: classes
  end

  def section_heading(text, options = {})
    size_classes = {
      small: "text-2xl sm:text-3xl",
      medium: "text-3xl sm:text-4xl", 
      large: "text-4xl sm:text-5xl lg:text-6xl"
    }
    
    size = options[:size] || :medium
    classes = "font-bold mb-4 sm:mb-6 #{size_classes[size]}"
    
    content_tag :h1, text, class: classes
  end

  def responsive_text(text, options = {})
    size_classes = {
      small: "text-sm sm:text-base",
      medium: "text-base sm:text-lg",
      large: "text-lg sm:text-xl"
    }
    
    size = options[:size] || :medium
    classes = "text-gray-700 leading-relaxed #{size_classes[size]}"
    
    content_tag :p, text, class: classes
  end

  def professional_photo(size = "medium", options = {})
    render "shared/professional_photo", 
           size: size, 
           show_title: options[:show_title] != false,
           show_subtitle: options[:show_subtitle] != false,
           class: options[:class]
  end

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
end