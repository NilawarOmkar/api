class CreateLocations < ActiveRecord::Migration[7.2]
  def change
    create_table :locations do |t|
      t.string :lot_number
      t.references :loan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
