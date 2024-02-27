class SendMailJob < ApplicationJob
  queue_as :default

  def perform(message_id, receiver, sender)
    message = Message.find_by(id: message_id)
    return if !message || message.notified || message.read
    NotifyMailer.new_message(receiver, sender).deliver_now
    receiver.set_messages_notified!(message.created_at)
  end
end
