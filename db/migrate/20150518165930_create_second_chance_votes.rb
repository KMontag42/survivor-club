class CreateSecondChanceVotes < ActiveRecord::Migration
  def change
    create_table :second_chance_votes do |t|
      t.integer :second_chance_potential_id
      t.integer :user_id

      t.timestamps
    end
  end
end
