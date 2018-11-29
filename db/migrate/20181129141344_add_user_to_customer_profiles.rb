class AddUserToCustomerProfiles < ActiveRecord::Migration[5.2]
  def change
    add_reference :customer_profiles, :user, foreign_key: true
  end
end
