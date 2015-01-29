class CreateContestant < ActiveRecord::Migration
  def change
    create_table :contestants do |t|
      t.string :name
      t.integer :age
      t.references :seasons, :index => true
      t.string :from
      t.string :job

      t.timestamps
    end
  end
end
