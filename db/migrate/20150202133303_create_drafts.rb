class CreateDrafts < ActiveRecord::Migration
  def change
    create_table :drafts do |t|
      t.references :season, index: true

      t.timestamps
    end
  end
end
