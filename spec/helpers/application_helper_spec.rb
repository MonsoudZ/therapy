require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#site_content" do
    let!(:site_content) { FactoryBot.create(:site_content, key: "test_key", content: "Test content", content_type: "text") }
    let!(:html_content) { FactoryBot.create(:site_content, key: "html_key", content: "<strong>Bold text</strong>", content_type: "html") }

    it "returns content for existing key" do
      expect(helper.site_content("test_key")).to eq("Test content")
    end

    it "returns default content for non-existing key" do
      expect(helper.site_content("non_existing_key", "Default content")).to eq("Default content")
    end

    it "returns nil for non-existing key without default" do
      expect(helper.site_content("non_existing_key")).to be_nil
    end

    it "returns HTML content safely for html content_type" do
      result = helper.site_content("html_key")
      expect(result).to eq("<strong>Bold text</strong>")
      expect(result).to be_html_safe
    end

    it "returns content safely for markdown content_type" do
      markdown_content = FactoryBot.create(:site_content, key: "markdown_key", content: "# Heading", content_type: "markdown")
      result = helper.site_content("markdown_key")
      expect(result).to eq("# Heading")
      expect(result).to be_html_safe
    end

    it "returns plain text for text content_type" do
      result = helper.site_content("test_key")
      expect(result).to eq("Test content")
      expect(result).not_to be_html_safe
    end
  end

  describe "#cta_button" do
    it "creates a link with default classes" do
      result = helper.cta_button("Click Me", "/path")
      expect(result).to include("Click Me")
      expect(result).to include("href=\"/path\"")
      expect(result).to include("rounded-xl")
      expect(result).to include("text-white")
    end

    it "accepts custom options" do
      result = helper.cta_button("Click Me", "/path", class: "custom-class")
      expect(result).to include("custom-class")
    end
  end

  describe "#secondary_button" do
    it "creates a link with secondary button classes" do
      result = helper.secondary_button("Click Me", "/path")
      expect(result).to include("Click Me")
      expect(result).to include("href=\"/path\"")
      expect(result).to include("border-2")
      expect(result).to include("border-[#416970]")
    end
  end

  describe "#section_heading" do
    it "creates a heading with default size" do
      result = helper.section_heading("My Title")
      expect(result).to include("My Title")
      expect(result).to include("text-3xl sm:text-4xl")
    end

    it "creates a heading with custom size" do
      result = helper.section_heading("My Title", size: :large)
      expect(result).to include("My Title")
      expect(result).to include("text-4xl sm:text-5xl lg:text-6xl")
    end
  end

  describe "#responsive_text" do
    it "creates text with default size" do
      result = helper.responsive_text("Some text")
      expect(result).to include("Some text")
      expect(result).to include("text-base sm:text-lg")
    end

    it "creates text with custom size" do
      result = helper.responsive_text("Some text", size: :small)
      expect(result).to include("Some text")
      expect(result).to include("text-sm sm:text-base")
    end
  end

  describe "#professional_photo" do
    it "renders the professional photo partial" do
      expect(helper).to receive(:render).with("shared/professional_photo",
        size: "medium",
        show_title: true,
        show_subtitle: true,
        class: nil
      )
      helper.professional_photo
    end

    it "passes custom options" do
      expect(helper).to receive(:render).with("shared/professional_photo",
        size: "large",
        show_title: false,
        show_subtitle: false,
        class: "custom-class"
      )
      helper.professional_photo("large", show_title: false, show_subtitle: false, class: "custom-class")
    end
  end
end
