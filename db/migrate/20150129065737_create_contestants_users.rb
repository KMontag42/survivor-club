class CreateContestantsUsers < ActiveRecord::Migration
  def change
    create_table :contestants_users do |t|
      t.integer :contestant_id
      t.integer :user_id

      t.timestamps
    end
  end
end
