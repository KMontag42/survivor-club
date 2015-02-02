# == Schema Information
#
# Table name: drafts
#
#  id         :integer          not null, primary key
#  season_id  :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_drafts_on_season_id  (season_id)
#

class Draft < ActiveRecord::Base
  belongs_to :season
  has_many :drafts_contestants, class_name: "DraftsContestants"
  has_many :contestants, through: :drafts_contestants
end
