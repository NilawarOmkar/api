class CreateFinancials < ActiveRecord::Migration[7.2]
  def change
    create_table :financials do |t|
      t.decimal :available_to_draw
      t.decimal :principal_balance
      t.decimal :project_commitment_amount
      t.references :loan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
