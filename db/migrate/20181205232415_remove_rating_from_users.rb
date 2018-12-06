class RemoveRatingFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :rating, :integer
  end
end
