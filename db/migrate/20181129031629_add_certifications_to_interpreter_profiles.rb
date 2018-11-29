class AddCertificationsToInterpreterProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :interpreter_profiles, :certifications, :string
  end
end
