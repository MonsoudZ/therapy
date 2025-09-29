class SiteContent < ApplicationRecord
  include Searchable

  validates :key, presence: true, uniqueness: true
  validates :title, presence: true
  validates :content, presence: true
  validates :content_type, presence: true, inclusion: { in: %w[text html markdown] }

  scope :by_content_type, ->(type) { where(content_type: type) }
  scope :recent, -> { order(updated_at: :desc) }

  def content_preview(length = 100)
    strip_tags(content).truncate(length)
  end

  def html_content?
    content_type == 'html'
  end

  def markdown_content?
    content_type == 'markdown'
  end

  def text_content?
    content_type == 'text'
  end
end
