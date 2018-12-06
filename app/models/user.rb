class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lastseenable

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true

  has_and_belongs_to_many :received_calls, class_name: 'Call'

  #Reviews for interpreters
  has_many :reviews, foreign_key: 'interpreter_id'

  class << self

    def all_interpreters
      self.where(interpreter: true)
    end

    def all_customers
      self.where(interpreter: false)
    end

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

  def stars
    if self.interpreter?
      if self.reviews.empty?
        nil
      else
        (self.reviews.map { |rev| rev.rating } .sum / reviews.count.to_f).round(1)
      end
    else
      raise 'customers do not have a `stars` method'
    end
  end

  def reviews
    if self.interpreter?
      super
    else
      raise 'customers do not have a `reviews` method'
    end
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
