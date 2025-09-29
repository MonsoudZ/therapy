require 'rails_helper'

RSpec.describe SiteContent, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:key) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:content_type) }
    
    it { is_expected.to validate_uniqueness_of(:key) }
    
    it { is_expected.to validate_inclusion_of(:content_type).in_array(['text', 'html', 'markdown']) }
  end

  describe "instance methods" do
    it "is valid with valid attributes" do
      site_content = FactoryBot.build(:site_content)
      expect(site_content).to be_valid
    end

    it "is invalid without a key" do
      site_content = FactoryBot.build(:site_content, key: nil)
      expect(site_content).not_to be_valid
      expect(site_content.errors[:key]).to include("can't be blank")
    end

    it "is invalid with duplicate key" do
      FactoryBot.create(:site_content, key: "test_key")
      site_content = FactoryBot.build(:site_content, key: "test_key")
      expect(site_content).not_to be_valid
      expect(site_content.errors[:key]).to include("has already been taken")
    end

    it "is invalid with invalid content_type" do
      site_content = FactoryBot.build(:site_content, content_type: "invalid_type")
      expect(site_content).not_to be_valid
      expect(site_content.errors[:content_type]).to include("is not included in the list")
    end
  end

  describe "scopes" do
    let!(:html_content) { FactoryBot.create(:site_content, content_type: "html") }
    let!(:text_content) { FactoryBot.create(:site_content, content_type: "text") }
    let!(:markdown_content) { FactoryBot.create(:site_content, content_type: "markdown") }

    it "can filter by content_type" do
      expect(SiteContent.where(content_type: "html")).to include(html_content)
      expect(SiteContent.where(content_type: "html")).not_to include(text_content)
    end
  end
end
