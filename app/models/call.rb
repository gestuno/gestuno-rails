class Call < ApplicationRecord
  belongs_to :sender, class_name: "User"
  after_create :broadcast

  has_and_belongs_to_many :recipients, class_name: "User" # actually only 1 for now (length capped at 1)

  validates :sender, presence: true
  validates :recipients, presence: true, length: { is: 1, message: 'must be exactly 1 user' }
  validates :room_name, presence: true, uniqueness: true

  validates :twilio_sid, uniqueness: true, allow_nil: true # can find all other twilio info using this

  # # GLOBAL VARIABLE - STRIPE now charges AUD$1.50 flat rate
  # RATE = 150
  def interpreter
    recipients.first
  end

  def broadcast
    data = {
      senderName: sender.name,
      roomName: room_name
    }

    # ActionCable.server.broadcast "notifications_#{recipients.first.id}", data

    NotificationsChannel.broadcast_to(recipients.first, data)

    # ActionCable.server.broadcast "notifications_#{recipients.first}", data

  end

  def duration
    if end_time && start_time
      end_time - start_time
    else
      nil
    end
  end

end

# user = User.find(params[:id])
# UserChannel.broadcast_to(user, { notification: 'Test message' })
