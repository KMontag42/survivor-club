class CreateContestantTribes < ActiveRecord::Migration
  def change
    create_table :contestant_tribes do |t|
      t.references :contestant, index: true
      t.references :tribe, index: true

      t.timestamps
    end
  end
end
