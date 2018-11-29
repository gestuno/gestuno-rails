class CreateCustomerProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_profiles do |t|
      t.text :bio
      t.text :language
      t.string :gender

      t.timestamps
    end
  end
end
