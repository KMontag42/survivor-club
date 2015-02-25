class CreateChatMessages < ActiveRecord::Migration
  def change
    create_table :chat_messages do |t|
      t.string :message
      t.integer :user_id, index: true
      t.integer :episode_id, index: true

      t.timestamps
    end
  end
end
