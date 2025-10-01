module ButtonHelper
  def cta_button(text, path, options = {})
    default_classes = "rounded-xl px-6 sm:px-8 py-3 sm:py-4 text-white font-medium text-base sm:text-lg hover:opacity-90 transition-opacity"
    classes = options[:class] || default_classes
    style = options[:style] || "background-color: #416970;"

    link_to text, path, class: classes, style: style
  end

  def secondary_button(text, path, options = {})
    default_classes = "rounded-xl px-6 sm:px-8 py-3 sm:py-4 text-white font-medium text-base sm:text-lg hover:opacity-90 transition-opacity"
    classes = options[:class] || default_classes
    style = options[:style] || "background-color: #416970;"

    link_to text, path, class: classes, style: style
  end

  def danger_button(text, path, options = {})
    default_classes = "rounded-xl bg-red-600 px-6 sm:px-8 py-3 sm:py-4 text-white font-medium text-base sm:text-lg hover:bg-red-700 transition-colors"
    classes = options[:class] || default_classes

    link_to text, path, class: classes, method: options[:method],
            data: { confirm: options[:confirm] }
  end
end
