class CreateContestantsSeasons < ActiveRecord::Migration
  def change
    create_table :contestants_seasons, :id => false do |t|
      t.integer :contestant_id
      t.integer :season_id

      t.timestamps
    end
  end
end
