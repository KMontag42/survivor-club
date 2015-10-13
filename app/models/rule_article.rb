# == Schema Information
#
# Table name: rule_articles
#
#  id         :integer          not null, primary key
#  number     :integer
#  title      :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

class RuleArticle < ActiveRecord::Base
end
