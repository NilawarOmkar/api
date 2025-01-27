json.extract! loan, :id, :agreement_id, :agreement_type, :borrower_name, :formatted_address, :formatted_loan_type, :lender_branded_display_name, :loan_id, :loan_number, :loan_type, :status_text, :created_at, :updated_at
json.url loan_url(loan, format: :json)
