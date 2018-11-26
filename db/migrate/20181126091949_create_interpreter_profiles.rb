class CreateInterpreterProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :interpreter_profiles do |t|
      t.text :bio
      t.string :gender
      t.boolean :online

      t.timestamps
    end
  end
end
