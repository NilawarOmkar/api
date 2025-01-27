require "test_helper"

class LoansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @loan = loans(:one)
  end

  test "should get index" do
    get loans_url
    assert_response :success
  end

  test "should get new" do
    get new_loan_url
    assert_response :success
  end

  test "should create loan" do
    assert_difference("Loan.count") do
      post loans_url, params: { loan: { agreement_id: @loan.agreement_id, agreement_type: @loan.agreement_type, borrower_name: @loan.borrower_name, formatted_address: @loan.formatted_address, formatted_loan_type: @loan.formatted_loan_type, lender_branded_display_name: @loan.lender_branded_display_name, loan_id: @loan.loan_id, loan_number: @loan.loan_number, loan_type: @loan.loan_type, status_text: @loan.status_text } }
    end

    assert_redirected_to loan_url(Loan.last)
  end

  test "should show loan" do
    get loan_url(@loan)
    assert_response :success
  end

  test "should get edit" do
    get edit_loan_url(@loan)
    assert_response :success
  end

  test "should update loan" do
    patch loan_url(@loan), params: { loan: { agreement_id: @loan.agreement_id, agreement_type: @loan.agreement_type, borrower_name: @loan.borrower_name, formatted_address: @loan.formatted_address, formatted_loan_type: @loan.formatted_loan_type, lender_branded_display_name: @loan.lender_branded_display_name, loan_id: @loan.loan_id, loan_number: @loan.loan_number, loan_type: @loan.loan_type, status_text: @loan.status_text } }
    assert_redirected_to loan_url(@loan)
  end

  test "should destroy loan" do
    assert_difference("Loan.count", -1) do
      delete loan_url(@loan)
    end

    assert_redirected_to loans_url
  end
end
