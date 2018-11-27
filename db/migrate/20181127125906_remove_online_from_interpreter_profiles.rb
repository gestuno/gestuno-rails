class RemoveOnlineFromInterpreterProfiles < ActiveRecord::Migration[5.2]
  def change
    remove_column :interpreter_profiles, :online
  end
end
