class CreateVoteOuts < ActiveRecord::Migration
  def change
    create_table :vote_outs do |t|
      t.integer :season_id, index: true
      t.integer :contestant_id, index: true
      t.integer :episode_id, index: true

      t.timestamps
    end
  end
end
