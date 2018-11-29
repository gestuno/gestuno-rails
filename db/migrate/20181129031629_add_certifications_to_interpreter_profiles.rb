class AddCertificationsToInterpreterProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :interpreter_profiles, :certifications, :string
    # TODO add model validation from preselected list
  end
end
