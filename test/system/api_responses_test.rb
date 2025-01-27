require "application_system_test_case"

class ApiResponsesTest < ApplicationSystemTestCase
  setup do
    @api_response = api_responses(:one)
  end

  test "visiting the index" do
    visit api_responses_url
    assert_selector "h1", text: "Api responses"
  end

  test "should create api response" do
    visit api_responses_url
    click_on "New api response"

    fill_in "Data", with: @api_response.data
    click_on "Create Api response"

    assert_text "Api response was successfully created"
    click_on "Back"
  end

  test "should update Api response" do
    visit api_response_url(@api_response)
    click_on "Edit this api response", match: :first

    fill_in "Data", with: @api_response.data
    click_on "Update Api response"

    assert_text "Api response was successfully updated"
    click_on "Back"
  end

  test "should destroy Api response" do
    visit api_response_url(@api_response)
    click_on "Destroy this api response", match: :first

    assert_text "Api response was successfully destroyed"
  end
end
