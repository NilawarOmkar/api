require "test_helper"

class FinancialsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @financial = financials(:one)
  end

  test "should get index" do
    get financials_url
    assert_response :success
  end

  test "should get new" do
    get new_financial_url
    assert_response :success
  end

  test "should create financial" do
    assert_difference("Financial.count") do
      post financials_url, params: { financial: { available_to_draw: @financial.available_to_draw, loan_id: @financial.loan_id, principal_balance: @financial.principal_balance, project_commitment_amount: @financial.project_commitment_amount } }
    end

    assert_redirected_to financial_url(Financial.last)
  end

  test "should show financial" do
    get financial_url(@financial)
    assert_response :success
  end

  test "should get edit" do
    get edit_financial_url(@financial)
    assert_response :success
  end

  test "should update financial" do
    patch financial_url(@financial), params: { financial: { available_to_draw: @financial.available_to_draw, loan_id: @financial.loan_id, principal_balance: @financial.principal_balance, project_commitment_amount: @financial.project_commitment_amount } }
    assert_redirected_to financial_url(@financial)
  end

  test "should destroy financial" do
    assert_difference("Financial.count", -1) do
      delete financial_url(@financial)
    end

    assert_redirected_to financials_url
  end
end
