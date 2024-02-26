class AddEditedToMessage < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :edited, :boolean, default: false
  end
end
