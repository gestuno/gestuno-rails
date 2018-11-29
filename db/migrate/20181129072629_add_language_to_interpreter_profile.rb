class AddLanguageToInterpreterProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :interpreter_profiles, :language, :string
  end
end
