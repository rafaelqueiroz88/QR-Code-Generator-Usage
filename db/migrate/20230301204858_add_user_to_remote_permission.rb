class AddUserToRemotePermission < ActiveRecord::Migration[7.0]
  def change
    add_reference :remote_permissions, :user, null: false, foreign_key: true
  end
end
