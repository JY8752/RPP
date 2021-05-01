class AddColumnToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :stage_level, :integer, null: false
  end
end
