class SiteContent < ApplicationRecord
  validates :key, presence: true, uniqueness: true
  validates :title, presence: true
  validates :content, presence: true
  validates :content_type, presence: true, inclusion: { in: %w[text html markdown] }
end
