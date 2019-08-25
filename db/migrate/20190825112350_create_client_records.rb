class CreateClientRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :client_records do |t|
      t.references :client, index: true
      t.integer :systolic
      t.integer :diastolic
      t.integer :heart_rate
      t.integer :weight
      t.text :findings
      t.string :remarks
      t.timestamps
    end
  end
end
