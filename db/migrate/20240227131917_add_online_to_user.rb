class AddOnlineToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :online, :boolean, default: false
    add_column :users, :last_mailed, :datetime
  end
end
