class AddLanguageToInterpreterProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :interpreter_profiles, :language, :string
    # TODO add model validation from preselected list
  end
end
