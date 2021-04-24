class CreateStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :statuses do |t|
      t.references :role, null: false, foreign_key: true
      t.integer :hp, null: false
      t.integer :mp, null: false
      t.integer :attack, null: false
      t.integer :defence, null: false
      t.integer :next_level_point, null: false
      t.timestamps
    end
  end
end
