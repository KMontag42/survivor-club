class CreateTribes < ActiveRecord::Migration
  def change
    create_table :tribes do |t|
      t.string :name
      t.string :color
      t.references :season, index: true

      t.timestamps
    end
  end
end
