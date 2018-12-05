class AddReferenceInterpreterToReviews < ActiveRecord::Migration[5.2]
  def change
    add_reference :reviews, :interpreter
  end
end
