module ApplicationHelper
  include ButtonHelper
  include ContentHelper

  def page_title(title = nil)
    base = "Columbine Therapy"
    content_for(:title, title.present? ? "#{title} · #{base}" : base)
  end
end
