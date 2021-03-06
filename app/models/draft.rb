# == Schema Information
#
# Table name: drafts
#
#  id         :integer          not null, primary key
#  season_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  status     :string(255)      default("scheduled")
#
# Indexes
#
#  index_drafts_on_season_id  (season_id)
#

class Draft < ActiveRecord::Base
  belongs_to :season
  has_many :picks

  ROUND_TYPE = %w(cash drinking)
  STATUS = %w(scheduled started ended)

  def contestants
    picks.collect(&:contestant).uniq(&:id)
  end

  def players
    picks.collect(&:user).uniq(&:id)
  end
end
