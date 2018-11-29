class InterpreterProfile < ApplicationRecord
  belongs_to :user # exactly one user - UNIQUE
  validates :user, presence: :true, uniqueness: :true
end
