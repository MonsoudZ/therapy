module ApplicationHelper
  include ButtonHelper
  include ContentHelper

  def page_title(title = nil)
    base = "Columbine Therapy"
    content_for(:title, title.present? ? "#{title} · #{base}" : base)
  end

  # Render a responsive section heading. Supported sizes: :default, :large
  def section_heading(text, size: :default)
    size_classes = case size
    when :large
                     "text-4xl sm:text-5xl lg:text-6xl"
    else
                     "text-3xl sm:text-4xl"
    end
    content_tag(:h2, text, class: "font-bold #{size_classes}")
  end

  # Render responsive paragraph text. Supported sizes: :default, :small
  def responsive_text(text, size: :default)
    size_classes = case size
    when :small
                     "text-sm sm:text-base"
    else
                     "text-base sm:text-lg"
    end
    content_tag(:p, text, class: size_classes)
  end
end
