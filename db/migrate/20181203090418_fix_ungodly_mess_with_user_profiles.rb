class FixUngodlyMessWithUserProfiles < ActiveRecord::Migration[5.2]
  def change
    drop_table :interpreter_profiles
    drop_table :customer_profiles

    add_column :users, :external_avatar, :string
    add_column :users, :avatar, :string

    add_column :users, :language, :string
    add_column :users, :bio, :text
    add_column :users, :gender, :string
    add_column :users, :certifications, :string
  end
end
