class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lastseenable

  has_one :interpreter_profile
  has_one :customer_profile

  # validates :interpreter, # bool

  has_and_belongs_to_many :received_calls, class_name: 'Call'

  after_create :__dangerously_attach_profile! # triggers infinite loop if before_save

  before_destroy :__dangerously_destroy_own_profile!

  def profile
    self.interpreter_profile || self.customer_profile
  end

  def interpreter?
    interpreter
  end

  def role
    self.interpreter? ? :interpreter : :customer
  end

  def customer?
    !self.interpreter?
  end

  def online?
    self.last_seen.present? && self.last_seen >= (Time.now - 1.day)
    # TODO shorten time period by several orders of magnitude
  end

  private

  def __dangerously_attach_profile!
    profile_class = self.interpreter? ? InterpreterProfile : CustomerProfile
    profile_class.__dangerously_spawn!(self)
  end

  def __dangerously_destroy_own_profile!
    self.profile.__dangerously_destroy_self!
  end

  def interpreter_profile=
    raise 'Cannot manually attach a profile'
  end

  def customer_profile=
    raise 'Cannot manually attach a profile'
  end

  def interpreter # must be checked with question mark
    super
  end

  def delete # forbidden
    raise
  end

  def delete! # forbidden
    raise
  end
end
