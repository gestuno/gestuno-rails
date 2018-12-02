class AddAvatarToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :interpreter_profiles, :external_avatar, :string
    add_column :interpreter_profiles, :avatar, :string

    add_column :customer_profiles, :external_avatar, :string
    add_column :customer_profiles, :avatar, :string
  end
end
