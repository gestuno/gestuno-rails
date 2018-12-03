class Call < ApplicationRecord
  belongs_to :sender, class_name: "User"

  has_and_belongs_to_many :recipients, class_name: "User" # actually only 1 for now (length capped at 1)

  validates :sender, presence: true
  validates :recipients, presence: true, length: { is: 1, message: 'must be exactly 1 user' }
  validates :room_name, presence: true, uniqueness: true

  validates :twilio_sid, uniqueness: true, allow_nil: true # can find all other twilio info using this
  # # GLOBAL VARIABLE - STRIPE now charges AUD$1.50 flat rate
  # RATE = 150

end
