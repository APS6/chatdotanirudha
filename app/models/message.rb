class Message < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"

  validates :body, presence: true, length: { minimum: 1 }

  after_create_commit -> { broadcast_prepend_to("messages_#{sender_id * receiver_id}") }
  after_destroy_commit -> { broadcast_remove_to("messages_#{sender_id * receiver_id}") }
  after_update_commit -> { broadcast_replace_to("messages_#{sender_id * receiver_id}") }

  before_update :set_edited

  private

  def set_edited 
    if body_changed? 
      self.edited = true
    end
  end
end
