class AddSeasonIdToPicks < ActiveRecord::Migration
  def change
    add_column :picks, :season_id, :integer

    Pick.all.map { |x|
      x.season_id = 1
      x.save!
    }
  end
end
