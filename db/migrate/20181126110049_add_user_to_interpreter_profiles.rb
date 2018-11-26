class AddUserToInterpreterProfiles < ActiveRecord::Migration[5.2]
  def change
    add_reference :interpreter_profiles, :user, foreign_key: true
  end
end
