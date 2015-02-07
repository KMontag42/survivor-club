class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.integer :draft_id, index: true
      t.integer :contestant_id, index: true
      t.integer :user_id, index: true
      t.string :type

      t.timestamps
    end
  end
end
