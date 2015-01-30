class AddImageUrlToContestant < ActiveRecord::Migration
  def change
    add_column :contestants, :image_url, :string
  end
end
