class CreateCastaways < ActiveRecord::Migration
  def change
    create_table :castaways do |t|
      t.integer :season_id
      t.integer :original_tribe_id
      t.integer :swapped_tribe_id
      t.integer :merged_tribe_id
      t.integer :voted_out_episode_id
      t.integer :finish
      t.integer :tribal_votes
      t.integer :total_votes
      t.string :name

      t.timestamps
    end
  end
end
