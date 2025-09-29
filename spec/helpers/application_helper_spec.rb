require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  # Database-less setup: site_content method removed

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
