class UpdateLastSeenForExistingUsers < ActiveRecord::Migration[7.1]
  def up
    User.update_all('last_seen = created_at')
  end
end
