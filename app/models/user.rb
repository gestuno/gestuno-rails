class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lastseenable

  has_one :interpreter_profile # one or zero

  has_and_belongs_to_many :received_calls, class_name: "Call"

  def interpreter?
    self.interpreter_profile.present?
  end

  def customer?
    !self.interpreter?
  end

  def online?
    self.last_seen.present? && self.last_seen >= (Time.now - 1.day)
    # TODO shorten time period by several orders of magnitude
  end
end
