class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.datetime :birthdate
      t.string :contact_number
      t.string :address
      t.string :occupation
      t.timestamps
    end
  end
end
