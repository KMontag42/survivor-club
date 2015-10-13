class CreateRuleArticles < ActiveRecord::Migration
  def change
    create_table :rule_articles do |t|
      t.integer :number
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
