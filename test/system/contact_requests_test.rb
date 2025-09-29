require "application_system_test_case"

class ContactRequestsTest < ApplicationSystemTestCase
  setup do
    @contact_request = contact_requests(:one)
  end

  test "visiting the index" do
    visit contact_requests_url
    assert_selector "h1", text: "Contact requests"
  end

  test "should create contact request" do
    visit contact_requests_url
    click_on "New contact request"

    fill_in "Email", with: @contact_request.email
    fill_in "First name", with: @contact_request.first_name
    fill_in "Last name", with: @contact_request.last_name
    fill_in "Message", with: @contact_request.message
    fill_in "Phone", with: @contact_request.phone
    fill_in "Referral", with: @contact_request.referral
    fill_in "State", with: @contact_request.state
    fill_in "Subject", with: @contact_request.subject
    click_on "Create Contact request"

    assert_text "Contact request was successfully created"
    click_on "Back"
  end

  test "should update Contact request" do
    visit contact_request_url(@contact_request)
    click_on "Edit this contact request", match: :first

    fill_in "Email", with: @contact_request.email
    fill_in "First name", with: @contact_request.first_name
    fill_in "Last name", with: @contact_request.last_name
    fill_in "Message", with: @contact_request.message
    fill_in "Phone", with: @contact_request.phone
    fill_in "Referral", with: @contact_request.referral
    fill_in "State", with: @contact_request.state
    fill_in "Subject", with: @contact_request.subject
    click_on "Update Contact request"

    assert_text "Contact request was successfully updated"
    click_on "Back"
  end

  test "should destroy Contact request" do
    visit contact_request_url(@contact_request)
    click_on "Destroy this contact request", match: :first

    assert_text "Contact request was successfully destroyed"
  end
end
