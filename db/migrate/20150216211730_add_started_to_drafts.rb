class AddStartedToDrafts < ActiveRecord::Migration
  def change
    add_column :drafts, :started, :boolean
  end
end
