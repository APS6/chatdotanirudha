
class PresenceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "presence_channel"
    current_user.online! 
  end

  def unsubscribed
    current_user.offline!
  end
end
