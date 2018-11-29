class CustomerProfile < ApplicationRecord
  belongs_to :user #belongs to one user - UNIQUE
  validates :user, presence: :true, uniqueness: :true
end
