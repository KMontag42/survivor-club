class AddFromToContestant < ActiveRecord::Migration
  def change
    add_column :contestants, :hometown, :string
  end
end
