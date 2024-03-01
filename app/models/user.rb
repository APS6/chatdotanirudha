class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :username, presence: true, uniqueness: true

  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id", dependent: :destroy
  has_many :received_messages, class_name: "Message", foreign_key: "receiver_id", dependent: :destroy

  after_update_commit -> { broadcast_replace_to("status_#{id}", target: "status_#{id}", partial: 'shared/status', locals: { status: online, user: id }) }

  private

  def broadcast_presence_update
    ActionCable.server.broadcast("presence_channel_#{id}", { user_id: id, online: online })
  end

end
