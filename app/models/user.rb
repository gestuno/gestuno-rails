class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lastseenable

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true
  validates :rating, inclusion: { in: [1, 2, 3, 4, 5] }

  has_and_belongs_to_many :received_calls, class_name: 'Call'

  #Reviews for interpreters
  has_many :reviews

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
