require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  describe "devise modules" do
    it "includes database_authenticatable" do
      expect(Admin.devise_modules).to include(:database_authenticatable)
    end

    it "includes registerable" do
      expect(Admin.devise_modules).to include(:registerable)
    end

    it "includes recoverable" do
      expect(Admin.devise_modules).to include(:recoverable)
    end

    it "includes rememberable" do
      expect(Admin.devise_modules).to include(:rememberable)
    end

    it "includes validatable" do
      expect(Admin.devise_modules).to include(:validatable)
    end
  end

  describe "instance methods" do
    it "is valid with valid attributes" do
      admin = FactoryBot.build(:admin)
      expect(admin).to be_valid
    end

    it "is invalid without an email" do
      admin = FactoryBot.build(:admin, email: nil)
      expect(admin).not_to be_valid
      expect(admin.errors[:email]).to include("can't be blank")
    end

    it "is invalid with duplicate email" do
      FactoryBot.create(:admin, email: "test@example.com")
      admin = FactoryBot.build(:admin, email: "test@example.com")
      expect(admin).not_to be_valid
      expect(admin.errors[:email]).to include("has already been taken")
    end

    it "is invalid with invalid email format" do
      admin = FactoryBot.build(:admin, email: "invalid_email")
      expect(admin).not_to be_valid
      expect(admin.errors[:email]).to include("is invalid")
    end
  end
end
