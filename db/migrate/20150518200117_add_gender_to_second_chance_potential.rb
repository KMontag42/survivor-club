class AddGenderToSecondChancePotential < ActiveRecord::Migration
  def change
    add_column :second_chance_potentials, :gender, :string
  end
end
