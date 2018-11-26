class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :interpreter_profile

  def interpreter?
    self.interpreter_profile.present?
  end

  def customer?
    !self.interpreter?
  end
end
