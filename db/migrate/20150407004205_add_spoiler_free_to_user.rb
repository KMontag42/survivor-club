class AddSpoilerFreeToUser < ActiveRecord::Migration
  def change
    add_column :users, :spoiler_free, :boolean, default: false
  end
end
