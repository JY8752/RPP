class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles do |t|
      t.integer :role, null: false
      t.integer :level, null: false

      t.timestamps
    end
  end
end
