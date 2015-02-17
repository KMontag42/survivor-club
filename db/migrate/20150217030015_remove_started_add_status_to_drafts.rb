class RemoveStartedAddStatusToDrafts < ActiveRecord::Migration
  def change
    remove_column :drafts, :started
    add_column :drafts, :status, :string, default: "scheduled"
  end
end
