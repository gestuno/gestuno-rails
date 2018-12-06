class RemoveColumnUserFromReviews < ActiveRecord::Migration[5.2]
  def change
    remove_reference :reviews, :user
  end
end
