class AddRoleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :interpreter, :boolean, null: false, default: false
  end
end