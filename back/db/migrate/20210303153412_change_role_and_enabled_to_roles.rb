class ChangeRoleAndEnabledToRoles < ActiveRecord::Migration[6.1]
  def change
    execute 'delete from roles;'
    change_column :roles, :role, :integer, null: false, default: 0
    change_column :roles, :enabled, :boolean, null: false
  end
end
