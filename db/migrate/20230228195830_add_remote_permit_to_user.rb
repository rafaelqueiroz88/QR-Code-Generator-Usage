class AddRemotePermitToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_enabled, :string
    add_column :users, :token, :string
  end
end
