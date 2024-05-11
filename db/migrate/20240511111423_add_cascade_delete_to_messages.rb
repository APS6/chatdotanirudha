class AddCascadeDeleteToMessages < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :messages, column: :receiver_id
    remove_foreign_key :messages, column: :sender_id

    add_foreign_key :messages, :users, column: :receiver_id, on_delete: :cascade
    add_foreign_key :messages, :users, column: :sender_id, on_delete: :cascade
  end
end
