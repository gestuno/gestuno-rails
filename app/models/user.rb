class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lastseenable

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true

  has_and_belongs_to_many :received_calls, class_name: 'Call'

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
      digest = Digest::SHA256.hexdigest(self.name).to_i(16)
      (Random.new(digest).rand * 3) + 2
    else
      nil
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
