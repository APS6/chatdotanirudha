class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :username, presence: true, uniqueness: true

  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id", dependent: :destroy
  has_many :received_messages, class_name: "Message", foreign_key: "receiver_id", dependent: :destroy


  def set_messages_notified!(timestamp)
    self.received_messages.each do |message|
      if message.created_at < timestamp
        message.update(notified: true)
      end
    end
  end

end
