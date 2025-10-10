class FaqsController < ApplicationController
  def index
    @faqs = load_faqs
  end

  private

  def load_faqs
    @loaded_faqs ||= begin
      YAML.load_file(Rails.root.join("config/faqs.yml")).map(&:symbolize_keys)
    end
  end
end
