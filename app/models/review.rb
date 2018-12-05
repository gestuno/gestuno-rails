class Review < ApplicationRecord
  belongs_to :interpreter, class_name: "User"
  belongs_to :reviewer, class_name: "User"

  validates :interpreter, presence: true
  validates :rating, inclusion: { in: [1, 2, 3, 4, 5] }

end
