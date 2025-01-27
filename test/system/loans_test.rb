require "application_system_test_case"

class LoansTest < ApplicationSystemTestCase
  setup do
    @loan = loans(:one)
  end

  test "visiting the index" do
    visit loans_url
    assert_selector "h1", text: "Loans"
  end

  test "should create loan" do
    visit loans_url
    click_on "New loan"

    fill_in "Agreement", with: @loan.agreement_id
    fill_in "Agreement type", with: @loan.agreement_type
    fill_in "Borrower name", with: @loan.borrower_name
    fill_in "Formatted address", with: @loan.formatted_address
    fill_in "Formatted loan type", with: @loan.formatted_loan_type
    fill_in "Lender branded display name", with: @loan.lender_branded_display_name
    fill_in "Loan", with: @loan.loan_id
    fill_in "Loan number", with: @loan.loan_number
    fill_in "Loan type", with: @loan.loan_type
    fill_in "Status text", with: @loan.status_text
    click_on "Create Loan"

    assert_text "Loan was successfully created"
    click_on "Back"
  end

  test "should update Loan" do
    visit loan_url(@loan)
    click_on "Edit this loan", match: :first

    fill_in "Agreement", with: @loan.agreement_id
    fill_in "Agreement type", with: @loan.agreement_type
    fill_in "Borrower name", with: @loan.borrower_name
    fill_in "Formatted address", with: @loan.formatted_address
    fill_in "Formatted loan type", with: @loan.formatted_loan_type
    fill_in "Lender branded display name", with: @loan.lender_branded_display_name
    fill_in "Loan", with: @loan.loan_id
    fill_in "Loan number", with: @loan.loan_number
    fill_in "Loan type", with: @loan.loan_type
    fill_in "Status text", with: @loan.status_text
    click_on "Update Loan"

    assert_text "Loan was successfully updated"
    click_on "Back"
  end

  test "should destroy Loan" do
    visit loan_url(@loan)
    click_on "Destroy this loan", match: :first

    assert_text "Loan was successfully destroyed"
  end
end
