
class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "NotificationsChannel"
    # stream_from "notifications_#{current_user.id}"
    stream_for current_user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
