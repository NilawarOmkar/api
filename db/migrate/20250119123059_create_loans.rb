class CreateLoans < ActiveRecord::Migration[7.2]
  def change
    create_table :loans do |t|
      t.string :agreement_id
      t.string :agreement_type
      t.string :borrower_name
      t.string :formatted_address
      t.string :formatted_loan_type
      t.string :lender_branded_display_name
      t.integer :loan_id
      t.string :loan_number
      t.string :loan_type
      t.string :status_text

      t.timestamps
    end
  end
end
