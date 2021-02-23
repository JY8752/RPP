class AddUserIdRoles < ActiveRecord::Migration[6.1]
  def up
    execute 'delete from roles;'
    add_reference :roles, :user, null: false, index: true
  end

  def down
    remove_reference :roles, :user, index:true
  end
end
