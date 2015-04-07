class ChangeSpoilerFreeToShowSpoilersOnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :spoiler_free, :show_spoilers
  end
end
