class AddEnabledToRoles < ActiveRecord::Migration[6.1]
  def up
    add_column :roles, :enabled, :boolean
  end

  def down
    remove_column :roles, :enabled, :boolean
  end
end
