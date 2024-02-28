class AddReceiveMailToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :receive_mail, :boolean, default: true
  end
end
