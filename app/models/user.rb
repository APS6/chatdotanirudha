class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

  validates :username, presence: true, uniqueness: true

  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id", dependent: :destroy
  has_many :received_messages, class_name: "Message", foreign_key: "receiver_id", dependent: :destroy

  after_update_commit -> { broadcast_replace_to("status_#{id}", target: "status_#{id}", partial: 'shared/status', locals: { status: online, user: id }) }

  private

  def broadcast_presence_update
    ActionCable.server.broadcast("presence_channel_#{id}", { user_id: id, online: online })
  end

  def self.from_omniauth(auth)
    userExists = find_by(email: auth.info.email)

    if userExists
      if userExists.provider == auth.provider && userExists.uid == auth.uid
        return userExists
      else
        userExists.provider = auth.provider
        userExists.uid = auth.uid
        userExists.save
        return userExists
      end
    else 
      where(provider: auth.provider, uid: auth.uid). first_or_initialize do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name
      user.skip_confirmation!
      user.save!
      end
    end
  end
end
