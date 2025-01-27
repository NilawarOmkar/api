require "test_helper"

class ApiResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_response = api_responses(:one)
  end

  test "should get index" do
    get api_responses_url
    assert_response :success
  end

  test "should get new" do
    get new_api_response_url
    assert_response :success
  end

  test "should create api_response" do
    assert_difference("ApiResponse.count") do
      post api_responses_url, params: { api_response: { data: @api_response.data } }
    end

    assert_redirected_to api_response_url(ApiResponse.last)
  end

  test "should show api_response" do
    get api_response_url(@api_response)
    assert_response :success
  end

  test "should get edit" do
    get edit_api_response_url(@api_response)
    assert_response :success
  end

  test "should update api_response" do
    patch api_response_url(@api_response), params: { api_response: { data: @api_response.data } }
    assert_redirected_to api_response_url(@api_response)
  end

  test "should destroy api_response" do
    assert_difference("ApiResponse.count", -1) do
      delete api_response_url(@api_response)
    end

    assert_redirected_to api_responses_url
  end
end
