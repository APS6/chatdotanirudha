
class PresenceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "presence_channel"
  end

  def unsubscribed
  end
end
