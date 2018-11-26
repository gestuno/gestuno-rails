class Call < ApplicationRecord
  belongs_to :interpreter, class_name: "User" #, foreign_key: false
  belongs_to :customer, class_name: "User" #, foreign_key: false

  validates :interpreter, presence: true
  validates :customer, presence: true
end
