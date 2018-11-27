class InterpreterProfile < ApplicationRecord
  belongs_to :user # exactly one
  validates :user, presence: :true
end
