class AddReferenceReviewerToReviews < ActiveRecord::Migration[5.2]
  def change
    add_reference :reviews, :reviewer
  end
end
