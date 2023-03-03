class RemoveUserFromPermission < ActiveRecord::Migration[7.0]
  def change
    remove_column :remote_permissions, :user_id
  end
end
