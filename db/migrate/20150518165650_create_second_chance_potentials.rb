class CreateSecondChancePotentials < ActiveRecord::Migration
  def change
    create_table :second_chance_potentials do |t|
      t.string :name
      t.string :photo

      t.timestamps
    end
  end
end
