class CreateDraftsContestants < ActiveRecord::Migration
  def change
    create_table :drafts_contestants do |t|
      t.integer :draft_id
      t.integer :contestant_id

      t.timestamps
    end
  end
end
