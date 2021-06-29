class CreateEnemies < ActiveRecord::Migration[6.1]
  def change
    create_table :enemies do |t|
      t.string :name, null: false
      t.integer :stage_level, null: false

      t.timestamps
    end
  end
end
