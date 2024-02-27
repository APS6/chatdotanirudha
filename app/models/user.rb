class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :username, presence: true, uniqueness: true

  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id", dependent: :destroy
  has_many :received_messages, class_name: "Message", foreign_key: "receiver_id", dependent: :destroy


  def online!
    update(online: true)
    broadcast_presence_update
  end

  def offline!
    update(online: false)
    broadcast_presence_update
  end

  private

  def broadcast_presence_update
    ActionCable.server.broadcast("presence_channel_#{id}", { user_id: id, online: online })
  end

end
