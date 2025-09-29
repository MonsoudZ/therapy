require 'rails_helper'

RSpec.describe "Site Content Integration", type: :request do
  describe "Dynamic content in views" do
    let!(:hero_title) { FactoryBot.create(:site_content, key: "hero_title", content: "Custom Hero Title", content_type: "text") }
    let!(:hero_subtitle) { FactoryBot.create(:site_content, key: "hero_subtitle", content: "Custom Hero Subtitle", content_type: "text") }
    let!(:about_intro) { FactoryBot.create(:site_content, key: "about_intro", content: "Custom About Introduction", content_type: "text") }
    let!(:contact_intro) { FactoryBot.create(:site_content, key: "contact_intro", content: "Custom Contact Introduction", content_type: "text") }

    describe "Home page" do
      it "displays custom hero title" do
        get root_path
        expect(response.body).to include("Custom Hero Title")
      end

      it "displays custom hero subtitle" do
        get root_path
        expect(response.body).to include("Custom Hero Subtitle")
      end

      it "falls back to default content when site content is missing" do
        SiteContent.destroy_all
        get root_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include("Individual +")
      end
    end

    describe "About page" do
      it "displays custom about introduction" do
        get about_path
        expect(response.body).to include("Custom About Introduction")
      end

      it "falls back to default content when site content is missing" do
        SiteContent.destroy_all
        get about_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include("I'm Angela Keeley")
      end
    end

    describe "Contact page" do
      it "displays custom contact introduction" do
        get contact_path
        expect(response.body).to include("Custom Contact Introduction")
      end

      it "falls back to default content when site content is missing" do
        SiteContent.destroy_all
        get contact_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include("Please complete this form")
      end
    end
  end

  describe "HTML content rendering" do
    let!(:html_content) { FactoryBot.create(:site_content, key: "hero_title", content: "<strong>Bold Title</strong>", content_type: "html") }

    it "renders HTML content safely" do
      get root_path
      expect(response.body).to include("<strong>Bold Title</strong>")
    end
  end

  describe "Content updates" do
    let!(:site_content) { FactoryBot.create(:site_content, key: "hero_title", content: "Original Title", content_type: "text") }

    it "reflects content updates immediately" do
      get root_path
      expect(response.body).to include("Original Title")

      site_content.update!(content: "Updated Title")
      get root_path
      expect(response.body).to include("Updated Title")
    end
  end
end
