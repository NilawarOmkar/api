class CreateApiResponses < ActiveRecord::Migration[7.2]
  def change
    create_table :api_responses do |t|
      t.text :data

      t.timestamps
    end
  end
end
