class AddNotifedToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :notified, :boolean
  end
end
