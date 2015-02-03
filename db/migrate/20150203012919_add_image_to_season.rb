class AddImageToSeason < ActiveRecord::Migration
  def change
    add_column :seasons, :image_url, :string
  end
end
