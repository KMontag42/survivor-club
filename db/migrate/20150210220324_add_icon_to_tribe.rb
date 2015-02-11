class AddIconToTribe < ActiveRecord::Migration
  def change
    add_column :tribes, :icon, :string
  end
end
