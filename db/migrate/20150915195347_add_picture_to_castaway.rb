class AddPictureToCastaway < ActiveRecord::Migration
  def change
    add_column :castaways, :picture_url, :string
  end
end
