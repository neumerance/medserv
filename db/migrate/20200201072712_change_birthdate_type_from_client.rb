class ChangeBirthdateTypeFromClient < ActiveRecord::Migration[5.2]
  def change
    change_column :clients, :birthdate, :date
  end
end
