class CustomerProfile < ApplicationRecord
  # TODO - DRY up w. BaseProfile class

  private_class_method :create, :create!, :destroy_all

  belongs_to :user # exactly one unique user
  validates :user, presence: :true, uniqueness: :true

  def __dangerously_attach_user!(user) # instance method
    self.user = user
  end

  def __dangerously_destroy_self! # instance method
    destroy!
  end

  def self.__dangerously_spawn!(user) # class method
    spawned = self.new
    spawned.__dangerously_attach_user!(user)
    spawned.save!
  end

  private

  def user= val
    super val
  end

  def destroy!
    super
  end
end
