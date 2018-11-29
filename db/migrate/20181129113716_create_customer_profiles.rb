class CreateCustomerProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_profiles do |t|
      t.text :bio
      t.text :langauge
      t.string :gender

      t.timestamps
    end
  end
end
