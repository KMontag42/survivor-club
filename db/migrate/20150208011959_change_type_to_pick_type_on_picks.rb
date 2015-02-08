class ChangeTypeToPickTypeOnPicks < ActiveRecord::Migration
  def change
    rename_column :picks, :type, :pick_type
  end
end
