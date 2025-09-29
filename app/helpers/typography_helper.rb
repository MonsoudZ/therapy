module TypographyHelper
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

  def page_title(title, options = {})
    subtitle = options[:subtitle]
    classes = "text-3xl sm:text-4xl lg:text-5xl font-bold mb-4 sm:mb-6"

    content_tag :div, class: "text-center" do
      content_tag(:h1, title, class: classes) +
      (subtitle ? content_tag(:p, subtitle, class: "text-lg sm:text-xl text-gray-700 leading-relaxed") : "")
    end
  end
end
