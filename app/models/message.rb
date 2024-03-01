class Message < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"

  validates :body, presence: true, length: { minimum: 1 }

  after_create_commit -> { broadcast_prepend_to("messages_#{sender_id * receiver_id}") }
  after_create_commit -> { broadcast_replace_to("users", target: "user_#{sender_id}", partial: 'king_main/user', locals: { user: sender, message: body }) }
  after_destroy_commit -> { broadcast_remove_to("messages_#{sender_id * receiver_id}") }
  after_update_commit -> { broadcast_replace_to("messages_#{sender_id * receiver_id}") }

  before_update :set_edited

  after_create_commit do 
    receiver = self.receiver
    if !receiver.online && (receiver.last_mailed.nil? || receiver.last_mailed < Time.now - 1.minute) && receiver.receive_mail && receiver.last_seen < Time.now - 1.minute
      NotifyMailer.new_message(self.body, receiver, self.sender).deliver_now
      receiver.update(last_mailed: Time.now)
    end
  end
  private

  def set_edited 
    if body_changed? 
      self.edited = true
    end
  end
end
