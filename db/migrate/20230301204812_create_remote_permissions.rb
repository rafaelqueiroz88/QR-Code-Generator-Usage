class CreateRemotePermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :remote_permissions do |t|
      t.string :token
      t.string :is_enabled

      t.timestamps
    end
  end
end
