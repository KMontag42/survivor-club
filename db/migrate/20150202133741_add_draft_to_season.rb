class AddDraftToSeason < ActiveRecord::Migration
  def change
    add_column :seasons, :draft_id, :integer
  end
end
