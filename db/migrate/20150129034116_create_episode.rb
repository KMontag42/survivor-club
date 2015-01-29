class CreateEpisode < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :name
      t.integer :number
      t.references :season
      t.text :description

      t.timestamps
    end
  end
end
