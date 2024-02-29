class AddLastSeenToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :last_seen, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
