class CreateUserChats < ActiveRecord::Migration[6.0]
  def change
    create_table :user_chats do |t|
      t.integer :user_id, index: true
      t.integer :chat_id, index: true
      t.boolean :admin, default: false
      t.timestamps
    end
  end
end
