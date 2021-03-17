class AddColumnDeleteData < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :delete_date, :timestamp
  end

  def down
    remove_column :users, :delete_date, :timestamp
  end
end
