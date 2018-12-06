
class ReviewValidator < ActiveModel::Validator
  def validate(record)
    unless record.interpreter.interpreter?
      record.errors << "`interpreter` must be an interpreter."
    end
    unless record.reviewer.customer?
      record.errors << "`reviewer` must be a customer."
    end
  end
end

class Review < ApplicationRecord

  include ActiveModel::Validations

  belongs_to :interpreter, class_name: "User"
  belongs_to :reviewer, class_name: "User"

  validates :interpreter, presence: true
  validates :reviewer, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }
end
