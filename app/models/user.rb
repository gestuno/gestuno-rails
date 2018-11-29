class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lastseenable

  has_one :interpreter_profile 
  has_one :customer_profile

  has_and_belongs_to_many :received_calls, class_name: "Call"

  def profile
    interpreter_profile || customer_profile
  end

  def interpreter?
    # self.interpreter_profile.present?
    interpreter
  end

  def role
    interpreter ? 'interpreter' : 'customer'
  end

  def customer?
    !interpreter?
  end

  def online?
    self.last_seen.present? && self.last_seen >= (Time.now - 1.day)
    # TODO shorten time period by several orders of magnitude
  end
end
