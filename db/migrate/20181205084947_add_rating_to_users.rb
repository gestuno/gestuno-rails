class AddRatingToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :rating, :integer
  end
end
