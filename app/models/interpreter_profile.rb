class InterpreterProfile < ApplicationRecord
  belongs_to :user # exactly one
  validates :user, presence: :true

  validates :certifications, presence: :true
  validates :language, presence: :true
  #validates :stars, inclusion: {in [1, 2, 3, 4, 5] }


end
